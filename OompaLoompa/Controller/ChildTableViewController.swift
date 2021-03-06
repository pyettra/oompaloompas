//
//  ChildTableViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 26/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class ChildTableViewController: UIViewController, ModalViewControllerDelegate {
    
    @IBOutlet weak var childrenCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childrenCollectionView.delegate = self
        childrenCollectionView.dataSource = self
        childrenCollectionView.register(UINib(nibName: "ChildCard", bundle: nil), forCellWithReuseIdentifier: "cell")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollection), name: NSNotification.Name("atualizaChildren"), object: nil)
        MusicPlayer.shared.play(.two)
    }
    
    @objc func reloadCollection(_ notification: Notification) {
        childrenCollectionView.reloadData()
    }
    
    
    @IBAction func addChild(_ sender: Any) {
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        self.overlayBlurredBackgroundView()
    }
    
    func overlayBlurredBackgroundView() {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        
        view.addSubview(blurredBackgroundView)
    }
    
    func removeBlurredBackgroundView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ShowModalView" {
                if let viewController = segue.destination as? ModalViewController {
                    viewController.delegate = self
                    viewController.modalPresentationStyle = .overFullScreen
                }
            }
        }
    }
    
}

extension ChildTableViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Model.instance.children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ChildCard {
            cell.configure(child: Model.instance.children[indexPath.row])
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = cell.frame.width/10.0
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "ChildrenScreen", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ChildrenViewController
        let _ = vc.view
        vc.childImgView.image = Model.instance.children[indexPath.row].image
        self.navigationController?.pushViewController(vc, animated: true)
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: collectionView.frame.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.width/4 * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
}
