//
//  OpenLetterViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 09/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class OpenLetterViewController: UIViewController {

    @IBOutlet weak var drawImageview: UIImageView!
    
    var drawing: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawImageview.image = drawing
    }
    
    
    
    
}
