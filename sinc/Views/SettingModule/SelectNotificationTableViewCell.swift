//
//  SelectNotificationTableViewCell.swift
//  sinc
//
//  Created by mac on 09/03/21.
//

import UIKit

protocol SelectNotificationTableViewCellDelegate {
    func goToViewController(storyBoardID : StoryBoardIdentifiers , ViewControllerID : ViewControllerIdentifiers)
}


class SelectNotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkMaskNewMatch: UIButton!
    @IBOutlet weak var checkMarkNewMessage: UIButton!
    @IBOutlet weak var lblNewMessage: UILabel!
    @IBOutlet weak var lblNewMatch: UILabel!
    
    var delegate :SelectNotificationTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        lblNewMessage.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_14.rawValue)
        lblNewMatch.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_14.rawValue)
        
        lblNewMatch.text = localizedString.newMatch.getLocalizableString()
        lblNewMessage.text = localizedString.newMessage.getLocalizableString()
        
        checkMaskNewMatch.setUpCornerRadius(4)
        checkMaskNewMatch.setBorder(0.5)
        
        checkMarkNewMessage.setUpCornerRadius(4)
        checkMarkNewMessage.setBorder(0.5)
        
        checkMaskNewMatch.isSelected = false
        checkMarkNewMessage.isSelected = false
        
        checkMaskNewMatch.addTarget(self, action: #selector(btnCheckMarkTouchUpInside(_:)), for: .touchUpInside)
        checkMarkNewMessage.addTarget(self, action: #selector(btnCheckMarkTouchUpInside(_:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func onTapCell(indexPath : IndexPath){
        
    }
    
    @objc func btnCheckMarkTouchUpInside(_ sender : UIButton){
        if sender.isSelected {
            sender.isSelected = false
        }
        else{
            sender.isSelected = true
        }
        sender.setBackgroundImage(nil, for: .normal)
        sender.setBackgroundImage(UIImage(named: "selectedCheckMark"), for: .selected)
    }
}
