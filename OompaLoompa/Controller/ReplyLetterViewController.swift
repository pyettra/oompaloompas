//
//  ReplyLetterViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 09/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

class ReplyLetterViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var paperLetterView: UIView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPaperLetterView()
        hideKeyboardWhenTappedAround()
        replyTextView.delegate = self
        replyTextView.textColor = .lightGray
    }
    
    func setUpPaperLetterView() {
        sendButton.layer.cornerRadius = 10
        paperLetterView.layer.cornerRadius = 20
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Escreva aqui a cartinha do Papai Noel" && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }

    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Escreva aqui a cartinha do Papai Noel"
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
    
    @IBAction func sendBtn(_ sender: Any) {
        let letter = Letters(url:URL(fileURLWithPath: ""), type: "santa")
        
        letter.text = replyTextView.text
        
        Model.instance.children[0].letters.insert(letter, at: 0)
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
