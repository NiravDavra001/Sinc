//
//  EditProfileCellView.swift
//  SincDemo
//
//  Created by pc on 11/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit

class EditProfileCellView: UIView {
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var txtField : UITextField!
    @IBOutlet weak var button : UIButton!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setUpUI()
        
    }
    
    func setUpUI(){
        title.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        txtField.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        button.tintColor = .borderColor
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    func setPlaceholdertext(placeholder : String){
        txtField.placeholder = placeholder
    }
    
    func setTitleOfLabel(text : String){
        title.text = text
    }
    
    func setButtonImage(imageName : String){
        button.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("EditProfileCellView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
}
