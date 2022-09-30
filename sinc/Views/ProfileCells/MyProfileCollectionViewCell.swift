//
//  MyProfileCollectionViewCell.swift
//  sinc
//
//  Created by mac on 23/03/21.
//

import UIKit

class MyProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblSeeSwipe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblSeeSwipe.textColor = .tagViewRedColor
        lblSeeSwipe.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
    }

}
