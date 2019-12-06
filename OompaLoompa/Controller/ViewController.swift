//
//  ViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 20/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var onboardCollection: UICollectionView!
    @IBOutlet weak var onBoardPageControl: UIPageControl!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: onboardCollection.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OBCollectionCell"+String(indexPath.row + 1), for: indexPath) as? UICollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / width
        let roundedIndex = round(index)
        self.onBoardPageControl.currentPage = Int(roundedIndex)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        onboardCollection.delegate = self
        onboardCollection.dataSource = self
        // Do any additional setup after loading the view.
        
        
    }
    @IBAction func animate(_ sender: Any) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Animation", bundle: nil)
        var vc = storyboard.instantiateViewController(identifier: "animation") as FoldViewController
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }
    
    @IBAction func nextOnboardAction(_ sender: Any) {
        
        var storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        var vc = storyboard.instantiateViewController(identifier: "login") as ChildTableViewController
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }

}

