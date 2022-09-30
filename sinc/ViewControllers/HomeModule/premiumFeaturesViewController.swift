//
//  premiumFeaturesViewController.swift
//  SincDemo
//
//  Created by pc on 10/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit

class premiumFeaturesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var lblMothlyPrice: UILabel!
    @IBOutlet weak var lblUnlimited: UILabel!
    @IBOutlet weak var lblSee: UILabel!
    @IBOutlet weak var btnBuyNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PremiumFeaturesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PremiumFeaturesCollectionViewCell")
        
        centerView.setUpCornerRadius(6)
        centerView.setBorder(1)
        centerView.layer.borderColor = UIColor.appDarkGreen.cgColor
        
        lblMothlyPrice.font = UIFont(name: FontName.SemiBold.rawValue,size:FontSize.Size_28.rawValue)
        lblUnlimited.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        lblSee.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        
        lblMothlyPrice.text = "$0.99/month"
        lblUnlimited.text = "\u{2022} Unlimited swipe backs"
        lblSee.text = "\u{2022} See who swiped right and see mutuals \n   friends in their profile"
        
        btnBuyNow.setRoundedView()
        btnBuyNow.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        btnBuyNow.backgroundColor = .btnbackgroundPink
        btnBuyNow.tintColor = .white
        
        
    }
    @IBAction func onTapCloseBtn(_ sender: Any) {
        self.dismissViewController()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // collectionView.reloadData()
    }
}
extension premiumFeaturesViewController :UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PremiumFeaturesCollectionViewCell", for: indexPath) as! PremiumFeaturesCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
