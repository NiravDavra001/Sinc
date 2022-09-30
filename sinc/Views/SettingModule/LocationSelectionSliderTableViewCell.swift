//
//  LocationSelectionSliderTableViewCell.swift
//  sinc
//
//  Created by mac on 09/03/21.
//

import UIKit

protocol LocationSelectionSliderTableViewCellDelegate {
    func goToViewController(storyBoardID : StoryBoardIdentifiers , ViewControllerID : ViewControllerIdentifiers)
}

class LocationSelectionSliderTableViewCell: UITableViewCell {
    @IBOutlet weak var locationPicker: UISlider!
    @IBOutlet weak var firstMiles: UILabel!
    @IBOutlet weak var endMiles: UILabel!
    
    var lblShowMiles = UILabel()
    
    var delegate : LocationSelectionSliderTableViewCellDelegate?
        
    var totalDistance = 0
    var remainingDistance = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        totalDistance = Int(locationPicker.frame.width + locationPicker.frame.width * 0.7)
        
        locationPicker.setThumbImage(UIImage(named: "SliderThumb"), for: .normal)
        locationPicker.minimumTrackTintColor = .appDarkGreen
        locationPicker.minimumValue = 0
        locationPicker.maximumValue = 60
        locationPicker.setValue(0, animated: false)
        
        
        lblShowMiles.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        self.locationPicker.addSubview(lblShowMiles)
        lblShowMiles.text = "\(0)"
        lblShowMiles.textColor = .black
        
        let trackRect = locationPicker.trackRect(forBounds: locationPicker.frame)
        let thumbRect = locationPicker.thumbRect(forBounds: locationPicker.bounds , trackRect: trackRect, value: locationPicker.value)
        self.lblShowMiles.center = CGPoint(x: thumbRect.midX , y: -10)
        
        firstMiles.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_12.rawValue))
        firstMiles.textColor = .buttonFontColor
        
        endMiles.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_12.rawValue))
        endMiles.textColor = .buttonFontColor
        
        locationPicker.addTarget(self, action: #selector(sliderValueChange(_:)), for: .valueChanged)
        self.contentView.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onTapCell(indexPath : IndexPath){
        
    }
    
    @objc func sliderValueChange(_ sender : UISlider){
        let trackRect = sender.trackRect(forBounds: sender.frame)
        let thumbRect = sender.thumbRect(forBounds: sender.bounds , trackRect: trackRect, value: sender.value)
        self.lblShowMiles.center = CGPoint(x: thumbRect.midX , y: -10)
        self.lblShowMiles.text = "\(Int(sender.value))"
    }
    
}

