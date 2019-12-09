//
//  SendDrawing.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 03/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit
import PencilKit

class SendDrawingViewController: UIViewController, PKCanvasViewDelegate, PKToolPickerObserver, UIScreenshotServiceDelegate {
    
    @IBOutlet weak var canvasView: PKCanvasView!
    @IBOutlet weak var undoBarButtonitem: UIBarButtonItem!
    @IBOutlet weak var redoBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var send: UIBarButtonItem!
    static let canvasOverscrollHeight: CGFloat = 500
    
    /// Data model for the drawing displayed by this view controller.
    var dataModelController: DataModelController!
    
    /// Private drawing state.
    var drawingIndex: Int = 0
    var hasModifiedDrawing = false
    
    // MARK: View Life Cycle
    
    /// Set up the drawing initially.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set up the canvas view with the first drawing from the data model.
        canvasView.alwaysBounceVertical = true
        canvasView.allowsFingerDrawing = true
        
        // Set up the tool picker, using the window of our parent because our view has not
        // been added to a window yet.
        if let window = parent?.view.window, let toolPicker = PKToolPicker.shared(for: window) {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            toolPicker.addObserver(self)
            
            updateLayout(for: toolPicker)
            canvasView.becomeFirstResponder()
        }
        
        // Always show a back button.
        navigationItem.leftItemsSupplementBackButton = true
        
        // Set this view controller as the delegate for creating full screenshots.
        parent?.view.window?.windowScene?.screenshotService?.delegate = self
    }
    
    /// When the view is resized, adjust the canvas scale so that it is zoomed to the default `canvasWidth`.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let canvasScale = canvasView.bounds.width / DataModel.canvasWidth
        canvasView.minimumZoomScale = canvasScale
        canvasView.maximumZoomScale = canvasScale
        canvasView.zoomScale = canvasScale
        
        // Scroll to the top.
        updateContentSizeForDrawing()
        canvasView.contentOffset = CGPoint(x: 0, y: -canvasView.adjustedContentInset.top)
    }
    
    /// When the view is removed, save the modified drawing, if any.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Update the drawing in the data model, if it has changed.
        if hasModifiedDrawing {
            dataModelController.updateDrawing(canvasView.drawing, at: drawingIndex)
        }
        
        // Remove this view controller as the screenshot delegate.
        view.window?.windowScene?.screenshotService?.delegate = nil
    }
    
    /// Hide the home indicator, as it will affect latency.
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // MARK: Actions
    
    /// Action method: Turn finger drawing on or off.
    @IBAction func toggleFingerPencilDrawing(_ sender: Any) {
        canvasView.allowsFingerDrawing.toggle()
    }
    
    /// Helper method to set a new drawing, with an undo action to go back to the old one.
    func setNewDrawingUndoable(_ newDrawing: PKDrawing) {
        let oldDrawing = canvasView.drawing
        undoManager?.registerUndo(withTarget: self) {
            $0.setNewDrawingUndoable(oldDrawing)
        }
        canvasView.drawing = newDrawing
    }
    
    // MARK: Canvas View Delegate
    
    /// Delegate method: Note that the drawing has changed.
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        hasModifiedDrawing = true
        updateContentSizeForDrawing()
    }
    
    /// Helper method to set a suitable content size for the canvas view.
    func updateContentSizeForDrawing() {
        // Update the content size to match the drawing.
        let drawing = canvasView.drawing
        let contentHeight: CGFloat
        
        // Adjust the content size to always be bigger than the drawing height.
        if !drawing.bounds.isNull {
            contentHeight = max(canvasView.bounds.height, (drawing.bounds.maxY + SendDrawingViewController.canvasOverscrollHeight) * canvasView.zoomScale)
        } else {
            contentHeight = canvasView.bounds.height
        }
        canvasView.contentSize = CGSize(width: DataModel.canvasWidth * canvasView.zoomScale, height: contentHeight)
    }
    
    // MARK: Tool Picker Observer
    
    /// Delegate method: Note that the tool picker has changed which part of the canvas view
    /// it obscures, if any.
    func toolPickerFramesObscuredDidChange(_ toolPicker: PKToolPicker) {
        updateLayout(for: toolPicker)
    }
    
    /// Delegate method: Note that the tool picker has become visible or hidden.
    func toolPickerVisibilityDidChange(_ toolPicker: PKToolPicker) {
        updateLayout(for: toolPicker)
    }
    
    /// Helper method to adjust the canvas view size when the tool picker changes which part
    /// of the canvas view it obscures, if any.
    ///
    /// Note that the tool picker floats over the canvas in regular size classes, but docks to
    /// the canvas in compact size classes, occupying a part of the screen that the canvas
    /// could otherwise use.
    func updateLayout(for toolPicker: PKToolPicker) {
        let obscuredFrame = toolPicker.frameObscured(in: view)
        
        // If the tool picker is floating over the canvas, it also contains
        // undo and redo buttons.
        if obscuredFrame.isNull {
            canvasView.contentInset = .zero
            navigationItem.leftBarButtonItems = []
        }
        
        // Otherwise, the bottom of the canvas should be inset to the top of the
        // tool picker, and the tool picker no longer displays its own undo and
        // redo buttons.
        else {
            canvasView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.bounds.maxY - obscuredFrame.minY, right: 0)
            navigationItem.leftBarButtonItems = [undoBarButtonitem, redoBarButtonItem]
        }
        canvasView.scrollIndicatorInsets = canvasView.contentInset
    }
    
    // MARK: Screenshot Service Delegate
    
    /// Delegate method: Generate a screenshot as a PDF.
    func screenshotService(
        _ screenshotService: UIScreenshotService,
        generatePDFRepresentationWithCompletion completion:
        @escaping (_ PDFData: Data?, _ indexOfCurrentPage: Int, _ rectInCurrentPage: CGRect) -> Void) {
        
        // Find out which part of the drawing is actually visible.
        let drawing = canvasView.drawing
        let visibleRect = canvasView.bounds
        
        // Convert to PDF coordinates, with (0, 0) at the bottom left hand corner,
        // making the height a bit bigger than the current drawing.
        let pdfWidth = DataModel.canvasWidth
        let pdfHeight = drawing.bounds.maxY + 100
        let canvasContentSize = canvasView.contentSize.height - SendDrawingViewController.canvasOverscrollHeight
        
        let xOffsetInPDF = pdfWidth - (pdfWidth * visibleRect.minX / canvasView.contentSize.width)
        let yOffsetInPDF = pdfHeight - (pdfHeight * visibleRect.maxY / canvasContentSize)
        let rectWidthInPDF = pdfWidth * visibleRect.width / canvasView.contentSize.width
        let rectHeightInPDF = pdfHeight * visibleRect.height / canvasContentSize
        
        let visibleRectInPDF = CGRect(
            x: xOffsetInPDF,
            y: yOffsetInPDF,
            width: rectWidthInPDF,
            height: rectHeightInPDF)
        
        // Generate the PDF on a background thread.
        DispatchQueue.global(qos: .background).async {
            
            // Generate a PDF.
            let bounds = CGRect(x: 0, y: 0, width: pdfWidth, height: pdfHeight)
            let mutableData = NSMutableData()
            UIGraphicsBeginPDFContextToData(mutableData, bounds, nil)
            UIGraphicsBeginPDFPage()
            
            // Generate images in the PDF, strip by strip.
            var yOrigin: CGFloat = 0
            let imageHeight: CGFloat = 1024
            while yOrigin < bounds.maxY {
                let imgBounds = CGRect(x: 0, y: yOrigin, width: DataModel.canvasWidth, height: min(imageHeight, bounds.maxY - yOrigin))
                let img = drawing.image(from: imgBounds, scale: 2)
                img.draw(in: imgBounds)
                yOrigin += imageHeight
            }
            
            UIGraphicsEndPDFContext()
            
            // Invoke the completion handler with the generated PDF data.
            completion(mutableData as Data, 0, visibleRectInPDF)
        }
    }
    
    
    @IBAction func send(_ sender: Any) {
        
        
        
       //let drawing = Letters(url: canvasView.drawing, type: .drawing)
    
    }
    
}
