//
//  ViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 20/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func next(_ sender: Any) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        var vc = storyboard.instantiateViewController(identifier: "login") as ChildTableViewController
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }
    
}

