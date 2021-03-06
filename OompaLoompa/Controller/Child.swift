//
//  ChildModel.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 26/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class Child {
    var name: String
    var image: UIImage
    var letters: [Letters]{
        get{
            return Letters.getAllObjects
        }
        set{
            Letters.saveAllObjects(allObjects: newValue)
            NotificationCenter.default.post(name: NSNotification.Name("updateLetters"), object: nil, userInfo: nil)
        }
    }
    
    
    init(name: String, image: UIImage, letters: [Letters]) {
        self.name = name
        self.image = image
    }
    
}
