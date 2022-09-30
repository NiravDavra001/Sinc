//
//  HeaderForSettingCell.swift
//  sinc
//
//  Created by mac on 09/03/21.
//

import UIKit


class HeaderForSettingCell: UITableViewHeaderFooterView {
    @IBOutlet weak var lblTitle : UILabel!
    
    @IBOutlet weak var btnSwitch: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func draw(_ rect: CGRect) {
        lblTitle.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
    }
    

}
