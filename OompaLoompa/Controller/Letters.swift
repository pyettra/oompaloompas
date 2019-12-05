//
//  Letters.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 05/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class Letters {
    var url: URL
    var type: Type
    
    init(url: String, type: Type) {
        self.url = NSURL(string: url) as! URL
        self.type = type
    }
}

enum Type {
    case santa
    case audio
    case drawing
}


