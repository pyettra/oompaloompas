//
//  Letters.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 05/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import PencilKit

class Letters {
    var url: URL
    var type: Type
    var text: String?
    var id: String
    
    init(url: URL, type: Type, id: String) {
        self.url = url
        self.type = type
        self.id = id
    }
    
    static func createLetter(drawing: PKDrawing) -> Letters {
        let image = drawing.image(from: drawing.bounds, scale: 1)
        let uuid = UUID().uuidString
        let letterURL = Model.instance.getDirectory().appendingPathComponent(uuid)
        do{
            try FileManager.default.createDirectory(at: letterURL, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print("erro ao criar diretorio", error.description)
        }
        let drawURL = saveDraw(image: image, at: letterURL)
        return Letters(url: drawURL, type: .drawing, id: uuid)
    }
    
    static func createLetter(audioURL: URL) -> Letters {
        
        let uuid = UUID().uuidString
        let letterURL = Model.instance.getDirectory().appendingPathComponent(uuid)
        let newPath = letterURL.appendingPathComponent("audio").appendingPathExtension("m4a")
        do{
            try FileManager.default.createDirectory(at: letterURL, withIntermediateDirectories: false, attributes: nil)
            try FileManager.default.moveItem(at: audioURL, to: newPath)
        } catch let error as NSError {
            print("erro ao criar diretorio", error.description)
        }
        
        return Letters(url: newPath, type: .audio, id: uuid)
    }
    
    static func saveDraw(image: UIImage, at url: URL) -> (URL) {
        let drawURL = url.appendingPathComponent("draw").appendingPathExtension("png")
        do {
            try image.pngData()?.write(to: drawURL, options: .atomic)
        } catch let error {
            print(error.localizedDescription)
        }
        return drawURL
    }
    
    private func getImage() -> UIImage {
        let data = try? Data(contentsOf: self.url)
        guard let image = UIImage(data: data!) else {
            fatalError()
        }
        return image
    }
    
    private func getAudio() -> AVPlayerItem {
        let playerItem = AVPlayerItem(url: self.url)
        
        return playerItem
    }
    
}

enum Type {
    case santa
    case audio
    case drawing
}


