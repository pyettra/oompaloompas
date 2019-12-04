//
//  ModalViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 28/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    func removeBlurredBackgroundView()
}

class ModalViewController: UIViewController {
    
    weak var delegate: ModalViewControllerDelegate?
    
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalView.layer.cornerRadius = modalView.frame.width/17.0
        modalView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
    }
    
    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.clear
        
    }
    
}
