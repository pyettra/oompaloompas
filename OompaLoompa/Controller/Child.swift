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
    var letters: [Letters]
    var id: Int
    
    init(name: String, image: UIImage, letters: [Letters], id: Int) {
        self.name = name
        self.image = image
        self.letters = letters
        self.id = id
    }
    
}
