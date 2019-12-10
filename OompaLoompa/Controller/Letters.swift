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

class Letters: Codable {
    var url: URL
    var type: String
    var text: String?
    var id: String
    
    static var getAllObjects: [Letters] {
         if let objects = UserDefaults.standard.value(forKey: "letters") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Letters] {
               return objectsDecoded
            } else {
               return []
            }
         } else {
            return []
         }
      }

    static func saveAllObjects(allObjects: [Letters]) {
         let encoder = JSONEncoder()
         if let encoded = try? encoder.encode(allObjects){
            UserDefaults.standard.set(encoded, forKey: "letters")
         }
    }
    
    init(url: URL, type: String, id: String = "0") {
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
        return Letters(url: drawURL, type: "drawing", id: uuid)
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
    
    func getData(letter: Letters) {
        if letter.type == "audio" {
            getAudio()
        } else if letter.type == "drawing" {
            getImage()
        } else {
            getText()
        }
    }
    
    func getImage() -> UIImage {
        //let newUrl = URL(fileURLWithPath: self.url.path)
        let newURL = Model.instance.getDirectory().appendingPathComponent(self.id).appendingPathComponent("draw").appendingPathExtension("png")
        
        let data = try? Data(contentsOf: newURL)
        guard let image = UIImage(data: data!) else {
            //fatalError()
            return UIImage(named: "elfo")!
        }
        return image

    }
    
    func getAudio() -> AVPlayerItem {
        let newURL = Model.instance.getDirectory().appendingPathComponent(self.id).appendingPathExtension("m4a")
        
        let playerItem = AVPlayerItem(url: newURL)
        
        return playerItem
    }
    
    func getText() -> String {
        return text ?? ""
    }
    
}

enum Type {
    case santa
    case audio
    case drawing
}


