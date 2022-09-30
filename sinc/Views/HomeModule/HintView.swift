//
//  HintView.swift
//  sinc
//
//  Created by mac on 12/04/21.
//

import UIKit

class HintView: UIView {

    @IBOutlet weak var leftSwipeImage: UIImageView!
    @IBOutlet weak var rightSWipeImage: UIImageView!
    
    @IBOutlet weak var lblSwipeLeft: UILabel!
    @IBOutlet weak var lblSwipeRight: UILabel!
    
    @IBOutlet weak var lblLeft: UILabel!
    @IBOutlet weak var lblRight: UILabel!
    
    @IBOutlet weak var lblPremium: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    func setUpUI(){
        lblSwipeLeft.font = UIFont(name: FontName.Bold.rawValue, size: FontSize.Size_12.rawValue)
        lblSwipeRight.font = UIFont(name: FontName.Bold.rawValue, size: FontSize.Size_12.rawValue)
        lblLeft.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_12.rawValue)
        lblRight.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_12.rawValue)
        lblPremium.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        animateImageView()
    }
    
    func animateImageView(){
        let curCenter = self.leftSwipeImage.center.x
        let curRightCenter = self.rightSWipeImage.center.x
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse,.curveEaseIn], animations: {
            self.leftSwipeImage.center.x = curCenter - 30
            self.leftSwipeImage.alpha = 0.8
            self.rightSWipeImage.alpha = 0.8
            self.rightSWipeImage.center.x = curRightCenter + 30

        }) { (_) in
            self.leftSwipeImage.center.x = curCenter
            self.rightSWipeImage.center.x = curRightCenter
            self.leftSwipeImage.alpha = 1.0
            self.rightSWipeImage.alpha = 1.0
        }
    }
    
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "HintView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
        
    }
    
}
