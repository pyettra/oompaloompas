//
//  ChildrenViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 22/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class ChildrenViewController: UIViewController {

    @IBOutlet weak var lettersCollection: UICollectionView!
    @IBOutlet weak var childImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lettersCollection.delegate = self
        lettersCollection.dataSource = self
        lettersCollection.register(UINib(nibName: "LetterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "letterCell")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollection), name: NSNotification.Name("updateLetters"), object: nil)
        
        childImgView.layer.cornerRadius = 102
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigation()

    }
    @objc func reloadCollection(_ notification: Notification) {
        lettersCollection.reloadData()
    }
    
    @IBAction func acessoPais(_ sender: Any) {
        touchIdAction()
    }
    
    func touchIdAction() {
           
           print("hello there!.. You have clicked the touch ID")
           
           let myContext = LAContext()
           let myLocalizedReasonString = "Biometric Authntication testing !! "
           
           var authError: NSError?
           if #available(iOS 8.0, macOS 10.12.1, *) {
               if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                   myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                       
                       DispatchQueue.main.async {
                           if success {
                               
                           } else {
                               
                           }
                       }
                   }
               } else {
            
               }
           } else {
           }
           
           
       }
    
    func setUpNavigation() {
//        let replyButton: UIButton = UIButton(type: .system)
//        replyButton.addTarget(self, action: #selector(replyLetter), for: .touchUpInside)
//        replyButton.setTitle("reply letter", for: .normal)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: replyButton)
        
    }
    
    @objc func replyLetter(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard.init(name: "ChildrenScreen", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(identifier: "replyLetter") as! ReplyLetterViewController
        
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }
    
    
    @IBAction func elfTalking(_ sender: Any) {
        
    }
    
    @IBAction func sendDrawing(_ sender: Any) {
    }
    
    
    @IBAction func sendAudio(_ sender: Any) {
    }
    
    
    @IBAction func replyLetters(_ sender: Any) {
        
        
    }
    
    @IBAction func unwindToChildrenLetters(_ unwindSegue: UIStoryboardSegue) {
        print("sjdkasjdlsakz")
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
    
}

extension ChildrenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.instance.children[0].letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "letterCell", for: indexPath) as? LetterCollectionViewCell {
            cell.configure(letter: Model.instance.children[0].letters[indexPath.row])
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = cell.frame.width/10.0
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "ChildrenScreen", bundle: nil)
        
        
        
        
        let letter = Model.instance.children[0].letters[indexPath.row]
        
        switch letter.type {
        case "audio":
            let storyboard: UIStoryboard = UIStoryboard(name: "audioRecord", bundle: nil)
            
            let vc = storyboard.instantiateViewController(identifier: "playerView") as! PlayerViewController
            
            let newURL = Model.instance.getDirectory().appendingPathComponent(letter.id)
                .appendingPathComponent("audio")
                .appendingPathExtension("m4a")
            
            vc.path = newURL
            vc.modalPresentationStyle = .fullScreen
            self.show(vc, sender: self)
            break
            
        case "drawing":
            let vc = storyboard.instantiateViewController(identifier: "openLetter") as! OpenLetterViewController
            
            let drawing = letter.getImage()
            
            vc.drawing = drawing
            vc.modalPresentationStyle = .fullScreen
            self.show(vc, sender: self)

        case "santa":
            let vcSanta = storyboard.instantiateViewController(identifier: "openSantaLetter") as! OpenSantaLetterViewController
            
            let _ = vcSanta.view
            vcSanta.replyTextView.text = letter.text ?? "tchau criança insuportável nunca poste texto vazio"
            vcSanta.modalPresentationStyle = .fullScreen
            self.show(vcSanta, sender: self)
        default:
            break
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 30, right: 0)
    }
    
    
}

