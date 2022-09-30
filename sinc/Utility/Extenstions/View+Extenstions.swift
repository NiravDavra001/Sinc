//
//  View+Extenstions.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import Foundation
import UIKit

extension UIView{
    
//    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    func setBorder( _ width : CGFloat , _ borderColour : UIColor? = nil){
        self.layer.borderWidth = width
        if borderColour != nil{
            self.layer.borderColor = borderColour!.cgColor
        }
        else{
            self.layer.borderColor = UIColor.borderColor.cgColor
        }
    }
    
    func setUpCornerRadius( _ radius : CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setRoundedView(){
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setUpButtonGradiantColor(leftColor : UIColor , rightColor : UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setButtonTitleGradiant(label : UILabel ,LeftColor : UIColor , RightColor : UIColor){
        let gradient = CAGradientLayer()
        gradient.colors = [LeftColor.cgColor, RightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.frame = self.bounds
        self.layer.addSublayer(gradient)
        self.mask = label
    }
    
    func setGradiantBorder(sender : UILabel ,width : CGFloat ,LeftColor : UIColor , RightColor : UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame =  CGRect(origin: .zero, size: self.bounds.size)
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 1)
        gradientLayer.colors = [LeftColor.cgColor, RightColor.cgColor]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.black.cgColor
        gradientLayer.mask = shapeLayer
        self.layer.addSublayer(gradientLayer)
    }
    
    func setImageGradient(LeftColor : UIColor , RightColor : UIColor){
        let view = UIView(frame: self.frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [LeftColor.cgColor, RightColor.cgColor]
        gradient.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradient, at: 0)
        self.addSubview(view)
        self.bringSubviewToFront(view)
    }
    
    func applyShodowToBottom(){
        let shadowSize: CGFloat = 20
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        self.layer.shadowOpacity = 1
        let contactRect = CGRect(x: 0, y: 0, width: self.bounds.width, height: shadowSize)
        self.layer.shadowPath = UIBezierPath(roundedRect: contactRect, cornerRadius: 0).cgPath
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
    }
    
    func manageKeyboard(){
        let tap = UITapGestureRecognizer(target: self,action:#selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    func setFullShadow(){
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
    }
    
}
