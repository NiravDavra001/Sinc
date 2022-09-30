//
//  PremiumFeaturesPopupViewController.swift
//  sinc
//
//  Created by mac on 22/02/21.
//

import UIKit

class PremiumFeaturesPopupViewController: UIViewController {

    @IBOutlet weak var mainVIew: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var premiumTitle: UILabel!
    @IBOutlet weak var lblUnlimited: UILabel!
    @IBOutlet weak var lblSavedSearch: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnGetZNow: UIButton!
    @IBOutlet weak var lblLearnMore: UILabel!
    
    @IBOutlet weak var centerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mainVIew.setUpCornerRadius(6)
        topView.setUpButtonGradiantColor(leftColor: .appDarkGreen, rightColor: .appLightGreen)
        topLabel.font = UIFont(name: FontName.SemiBold.rawValue, size: CustomFontSize(size: FontSize.Size_20.rawValue))
        topLabel.textColor = .white
        
        premiumTitle.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        premiumTitle.textColor = .buttonFontColor
        
        lblUnlimited.font = UIFont(name: FontName.SemiBold.rawValue, size: CustomFontSize(size: FontSize.Size_24.rawValue))
        lblUnlimited.textColor = .fontDarkColor1
        
        lblPrice.font = UIFont(name: FontName.SemiBold.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        lblPrice.textColor = .appDarkGreen
        
        btnGetZNow.backgroundColor = .btnbackgroundPink
        btnGetZNow.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        btnGetZNow.tintColor = .white
        btnGetZNow.setRoundedView()
        
        lblSavedSearch.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        
        lblLearnMore.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        
        centerView.setUpCornerRadius(6)
        centerView.setBorder(1)
        centerView.layer.borderColor = UIColor.borderColor.cgColor
        
        
        
        
    }
    
    @IBAction func onTapGetNow(_ sender: Any) {
        self.presentViewController(controllerID: .PremiumFeaturesVC, storyBoardID: .Setting)
    }
    

    @IBAction func btnCloseTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
