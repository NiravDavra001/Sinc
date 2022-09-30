//
//  MessageTopCollectionViewCell.swift
//  sinc
//
//  Created by mac on 12/03/21.
//

import UIKit

class MessageTopCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        imageView.image = UIImage(named: "demoProfile")
        imageView.setRoundedView()
    }
}
