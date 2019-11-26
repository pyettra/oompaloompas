//
//  ParentConfigurationViewController.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 22/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import Foundation
import UIKit

class ParentConfigurationViewController: UICollectionViewController {
    
    @IBOutlet weak var NRespondidasLabel: UILabel!
    @IBOutlet weak var RespondidasLabel: UILabel!
    
    @IBOutlet weak var NaoRespondidasCollection: UICollectionView!
    @IBOutlet weak var RespondidasCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "respondidas_cell", for: indexPath) as! RespondidasCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
}
