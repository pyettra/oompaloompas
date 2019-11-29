//
//  ChildCard.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 27/11/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

class ChildCard: UICollectionViewCell {
    
    @IBOutlet weak var childImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    func configure(child: Child) {
        childImgView.image = child.image
        nameLbl.text = child.name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
