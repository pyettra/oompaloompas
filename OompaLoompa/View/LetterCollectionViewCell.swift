//
//  LetterCollectionViewCell.swift
//  OompaLoompa
//
//  Created by Pyettra Ferreira on 08/12/19.
//  Copyright © 2019 Pyettra Ferreira. All rights reserved.
//

import UIKit

class LetterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var letterImg: UIImageView!
    
    func configure(letter: Letters) {
        if letter.type == "santa" {
            letterImg.image = UIImage(named: "cartaFrente")
        } else {
            letterImg.image = UIImage(named: "carta02Frente")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
