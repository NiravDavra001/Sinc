//
//  MessageBottomTableViewCell.swift
//  sinc
//
//  Created by mac on 12/03/21.
//

import UIKit

class MessageBottomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imageUserProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        imageUserProfile.setRoundedView()
        
        lblUserName.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        lblStatus.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        lblTime.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
