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
    @IBOutlet weak var childImg: UIImageView!
    var imagePicker: ImagePicker!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var nameTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalView.layer.cornerRadius = modalView.frame.width/17.0
        modalView.layer.masksToBounds = true
        self.childImg.layer.cornerRadius = self.childImg.frame.size.width/2
        self.childImg.clipsToBounds = true
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
    }
    
    
    @IBAction func saveChild(_ sender: Any) {
        let child: Child = Child(name: nameTxtField.text ?? "", image: childImg.image!, letters: [], id: 1)
        Model.instance.children.append(child)
        NotificationCenter.default.post(name: NSNotification.Name("atualizaChildren"), object: nil, userInfo: nil)
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
        
    }
    
    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.clear
        
    }
    
}

extension ModalViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.childImg.image = image
    }
}
