//
//  ChildrenViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 22/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class ChildrenViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func elfTalking(_ sender: Any) {
        
    }
    
    @IBAction func sendDrawing(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "SendDrawing", bundle: nil)
        let vc: SendDrawingViewController = storyboard.instantiateViewController(identifier: "sendDrawing") as SendDrawingViewController
//        vc.modalPresentationStyle = .fullScreen
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.show(navigationController, sender: self)
//        self.present(navigationController, animated: true, completion: nil)
        
    }
    
    @IBAction func sendAudio(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "SendMail", bundle: nil)
        let vc: SendMailViewController = storyboard.instantiateViewController(identifier: "sendMail") as SendMailViewController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.show(navigationController, sender: self)
    }
    
    
}
