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
    
    init(url: URL, type: Type) {
        self.url = url
        self.type = type
    }
    
    static func createLetter(drawing: PKDrawing) -> Letters {
        let image = drawing.image(from: drawing.bounds, scale: 1)
        let url = saveDraw(image: image)
        return Letters(url: url, type: .drawing)
    }
    
    static func saveDraw(image: UIImage) -> URL {
        return URL(fileURLWithPath: "")
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


