//
//  OpenSantaLetterViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 09/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

class OpenSantaLetterViewController: UIViewController {
    
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var paperLetterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPaperLetterView()
        hideKeyboardWhenTappedAround()
    }
    
    func setUpPaperLetterView() {
        paperLetterView.layer.cornerRadius = 20
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        let letter = Letters(url:URL(fileURLWithPath: ""), type: "santa")
        
        letter.text = replyTextView.text
        
        Model.instance.children[0].letters.insert(letter, at: 0)
        
        self.navigationController?.popViewController(animated: true)
    }
    

}


