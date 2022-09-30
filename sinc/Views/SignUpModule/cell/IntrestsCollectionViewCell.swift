//
//  IntrestsCollectionViewCell.swift
//  SincDemo
//
//  Created by pc on 10/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit

class IntrestsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization coed
    }
    
    

    override func draw(_ rect: CGRect) {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.borderColor.cgColor
        self.contentView.layer.cornerRadius = self.contentView.frame.height / 2
        self.contentView.clipsToBounds = true
    }
}
