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
    var selectedChild: Child!
    var children: [Child] = []
    
    private init(){
        //number = UserDefaults.standard.object(forKey: "myNumber") as! Int
        number = 0
    }
    
    
    
    var number: Int {
        didSet{
            UserDefaults.standard.set(self.number, forKey: "myNumber")
        }
    }
    
    
    func getDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask )
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    
    

    

}


