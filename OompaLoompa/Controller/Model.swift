//
//  Model.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 26/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let instance = Model()
    
    private init(){}
    
    var children: [Child] = [
        Child(name: "Aurora", image: "moana.jpg"),
        Child(name: "Elsa", image: "elsa.jpg"),
        Child(name: "Anna", image: "anna.jpg")
    ]
    
}
