//
//  PremiumFeaturesCollectionViewCell.swift
//  SincDemo
//
//  Created by pc on 10/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit

class PremiumFeaturesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblPremiumTitle: UILabel!
    @IBOutlet weak var lblSeeCard: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layoutIfNeeded()
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        mainView.setUpButtonGradiantColor(leftColor: .appDarkGreen, rightColor: .appLightGreen)
        lblPremiumTitle.font = UIFont(name: FontName.Bold.rawValue, size: CustomFontSize(size: FontSize.Size_20.rawValue))
        lblSeeCard.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        
        lblSeeCard.textColor = .white
        lblPremiumTitle.textColor = .white
        mainView.layoutIfNeeded()
        
//        UIView.animate(withDuration: 0.5, delay: 0.4,
//          options: [.repeat, .autoreverse, .curveEaseIn],
//          animations: {[weak self] in
//                        self?.contentView.layoutIfNeeded()
//          },
//          completion: nil
//        )
    }
    
    

}
