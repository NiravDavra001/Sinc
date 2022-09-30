//
//  BottomNavPannel.swift
//  sinc
//
//  Created by mac on 04/02/21.
//

import UIKit

class BottomNavPannel: UIView {
    
    
    @IBOutlet weak var btnNext : UIButton!
    @IBOutlet weak var txtNext : UIButton!
    @IBOutlet weak var btnBack : UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        setUpUI()
    }
    
    func setUpUI(){
        self.applyShodowToBottom()
        btnNext.setUpButtonGradiantColor(leftColor: .appDarkGreen, rightColor: .appLightGreen)
        btnNext.setRoundedView()
        txtNext.titleLabel?.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        btnBack.titleLabel?.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        txtNext.setTitleColor(.buttonFontColor, for: .normal)
        btnBack.setTitleColor(.buttonFontColor, for: .normal)
    }
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "BottomNavPannel", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
    }

}
