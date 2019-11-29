//
//  ViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 20/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var onboardCollection: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OBCollectionCell"+String(indexPath.row + 1), for: indexPath) as? UICollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        onboardCollection.delegate = self
        onboardCollection.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func next(_ sender: Any) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        var vc = storyboard.instantiateViewController(identifier: "login") as ChildTableViewController
        vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: self)
    }
    

}

