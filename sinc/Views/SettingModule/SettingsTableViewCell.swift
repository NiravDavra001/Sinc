//
//  SettingsTableViewCell.swift
//  sinc
//
//  Created by mac on 09/03/21.
//

import UIKit

protocol SettingsTableViewCellDelegate {
    func goToViewController(storyBoardID : StoryBoardIdentifiers , ViewControllerID : ViewControllerIdentifiers)
}

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNotificationCount: UILabel!
    @IBOutlet weak var btnDisclouser: UIButton!
    
    var delegate : SettingsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setUpUI(){
        lblTitle.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        lblNotificationCount.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        
        lblTitle.textColor = .fontDarkColor1
        lblNotificationCount.text = "4"
        lblNotificationCount.setRoundedView()
    }
    
    func manageFontSizeAndColor(){
        lblTitle.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_14.rawValue)
        lblTitle.textColor = .appLightGreen
//        setButtonTitleGradiant(label: lblTitle, LeftColor: .appDarkGreen, RightColor: .appLightGreen)
    }
    
    
    func setLabelTitle(title : String){
        lblTitle.text = title
    }
    
    func setnotificationCountText(count : String){
        lblNotificationCount.text = count
    }
    
    func setNotificationLabelHideUnhide(hide : Bool){
        lblNotificationCount.isHidden = hide
    }
    
    func setDisclouserIndecaterHideUnhide(hide : Bool){
        btnDisclouser.isHidden = hide
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func onTapCell(indexPath : IndexPath){
        delegate?.goToViewController(storyBoardID: .Setting, ViewControllerID: .feedbackVC)
    }
    
}
