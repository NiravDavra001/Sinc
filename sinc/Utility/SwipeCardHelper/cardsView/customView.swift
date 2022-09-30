//
//  customView.swift
//
//

import UIKit
import SDWebImage

///    Create custom View That Contains The Elements (ImageView And TextView)
class customView: UIView {

    var imageName = String()
    var text = String()
    var imageView = UIImageView()
    var name = UILabel()
    var age = UILabel()
    var occupation = UILabel()
    var distance = UILabel()
    
    var userName = "",userAge = "",userOccupation = "",userDistance = ""
    
    convenience init(name : String,age : String,occupation : String,distance : String, imageName : String) {
        self.init()
        self.userName = name
        self.userAge = age
        self.userOccupation = occupation
        self.userDistance = distance
        self.imageName = imageName
        self.setView()
    }
///    create ImageView and TextView Programatically
    func setView(){
        self.addSubview(imageView)
        self.addSubview(name)
        self.addSubview(age)
        self.addSubview(occupation)
        self.addSubview(distance)
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 330 / 436, constant: 0).isActive = true
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16).isActive = true
        name.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 16).isActive = true
        
        age.translatesAutoresizingMaskIntoConstraints = false
        age.leadingAnchor.constraint(equalTo: name.trailingAnchor,constant: 10).isActive = true
        age.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 16).isActive = true
        
        occupation.translatesAutoresizingMaskIntoConstraints = false
        occupation.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16).isActive = true
        occupation.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 8).isActive = true
        
        distance.translatesAutoresizingMaskIntoConstraints = false
        distance.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16).isActive = true
        distance.topAnchor.constraint(equalTo: occupation.bottomAnchor,constant: 4).isActive = true
        
        name.textColor = .black
        age.textColor = .black
        occupation.textColor = .buttonFontColor
        distance.textColor = .buttonFontColor
        
        name.font = UIFont(name: FontName.SemiBold.rawValue, size: CustomFontSize(size: FontSize.Size_24.rawValue))
        age.font = UIFont(name: FontName.SemiBold.rawValue, size: CustomFontSize(size: FontSize.Size_24.rawValue))
        occupation.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_12.rawValue))
        distance.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_12.rawValue))
        
        if userAge == "" {
            name.text = userName
        }
        else{
            name.text = userName + ","
        }
        age.text = userAge
        occupation.text = userOccupation
        distance.text = userDistance
        imageView.sd_setImage(with: URL(string: imageName), completed: nil)
        
    }
}
