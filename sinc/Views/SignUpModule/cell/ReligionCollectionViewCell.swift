//
//  ReligionCollectionViewCell.swift
//  sinc
//
//  Created by mac on 05/02/21.
//

import UIKit

class ReligionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label : UILabel!
    
    var isrelselected = false
    @IBOutlet weak var mainVIew: UIView!
    @IBOutlet weak var selectBtnImageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.mainVIew.setRoundedView()
        mainVIew.setBorder(1)
        label.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_14.rawValue)
        selectBtnImageview.image = nil
        
    }
    
    func setTitle(text : String){
        label.text = text
    }
    
    override func select(_ sender: Any?) {
        
    }
    
    func selectCurItem() {
        selectBtnImageview.image = UIImage(named: "select_button")
    }
    func unselectCurItem(){
        selectBtnImageview.image = nil
        
    }
    
    
}
