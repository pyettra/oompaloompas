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

    @IBOutlet weak var lettersCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lettersCollection.delegate = self
        lettersCollection.dataSource = self
        lettersCollection.register(UINib(nibName: "LetterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "letterCell")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollection), name: NSNotification.Name("updateLetters"), object: nil)
    }
    
    @objc func reloadCollection(_ notification: Notification) {
        lettersCollection.reloadData()
    }
    
    
    @IBAction func elfTalking(_ sender: Any) {
        
    }
    
    @IBAction func sendDrawing(_ sender: Any) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "SendDrawing", bundle: nil)
//        let vc: UINavigationController = storyboard.instantiateInitialViewController()!
//        self.navigationController?.pushViewController(vc, animated: true)
//        let storyboard: UIStoryboard = UIStoryboard(name: "SendDrawing", bundle: nil)
//        let vc: PencilKitNavigationController = storyboard.instantiateInitialViewController()!
//        vc.modalPresentationStyle = .fullScreen
//        self.show(vc, sender: self)
    }
    
    
    @IBAction func sendAudio(_ sender: Any) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "SendMail", bundle: nil)
//        let vc: SendMailViewController = storyboard.instantiateViewController(identifier: "sendMail") as SendMailViewController
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen
//        self.show(navigationController, sender: self)
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
       //navegar para a modal de desenho, áudio ou carta
        

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

