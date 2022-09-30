//
//  constants.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import Foundation
import UIKit
import MapKit
import SocketIO



var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
var registerDetails = RegisterDetails()
var pickerView = UIPickerView()
var currentLatitued = CLLocationDegrees()
var currentLongitued = CLLocationDegrees()
var isLogPrinted = true

var updateLocationDistance = Double(50.0)

var isActivityIndicaterIsOn = false


var userID = UserDefaultManager.share.getModelDataFromUserDefults(userData: RegisterModel.self, key: .storeRegisterModel)?.data?.user?.id

func showActivityIndicator(uiView: UIView) {
    isActivityIndicaterIsOn = true
    activityIndicator.style = UIActivityIndicatorView.Style.large
    activityIndicator.tintColor = .borderColor
    activityIndicator.center = uiView.center
    uiView.addSubview(activityIndicator)
    activityIndicator.startAnimating()
}

func hideActivityIndicator(uiView: UIView) {
    isActivityIndicaterIsOn = false
    activityIndicator.removeFromSuperview()
    activityIndicator.stopAnimating()
}

/// sets Attributed Text
func setAttributedText(text1 : String ,text2 : String,fontsize1 : CGFloat,fontsize2 : CGFloat,fontColor1 : UIColor , fontColor2 : UIColor, fontName1 : String, fontName2 : String) -> NSAttributedString{
    
    let boldText = text1
    let attrs = [NSAttributedString.Key.font : UIFont(name: fontName1, size: CustomFontSize(size: fontsize1)) ,NSAttributedString.Key.foregroundColor : fontColor1]
    let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs as [NSAttributedString.Key : Any])

    let normalText = text2
    let normalAttr = [NSAttributedString.Key.font : UIFont(name: fontName2, size: CustomFontSize(size: fontsize2)),NSAttributedString.Key.foregroundColor : fontColor2]
    let normalString = NSMutableAttributedString(string:normalText,attributes: normalAttr as [NSAttributedString.Key : Any])

    attributedString.append(normalString)
    
    return attributedString
}

/// custom font size 
func CustomFontSize(size: CGFloat) -> CGFloat{
    var fontSize = size
//    fontSize = (UIScreen.main.bounds.height * size)/812
    if UIDevice().screenType == .iPhones_4_4S || UIDevice().screenType == .iPhones_5_5s_5c_SE {
      fontSize = (667*size)/812
    }
    if UIDevice().screenType == .iPhones_6_6s_7_8 {
      fontSize = (667*size)/812
    }
    if UIDevice().screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
      fontSize = (736*size)/812
    }
    if UIDevice().screenType == .iPhone_XSMax_ProMax {
      fontSize = (896*size)/812
    }
    if UIDevice().screenType == .iPhones_X_XS_12mini {
      fontSize = (812*size)/812
    }
    if UIDevice().screenType == .iPhone_XR_11 {
      fontSize = (896*size)/812
    }
    return fontSize
  }
/// manges View And Other View Elements Height as per device Size
func setHeightAsPerDeviceHeight(getHeight : CGFloat) -> CGFloat{
    let height = getHeight * UIScreen.main.bounds.height / 812
    return height
}
/// this is func for fatching Region Code
func getRegionCode() -> String {
    let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String
    return countryCode ?? "US"
}
///   this func for store userDefault Value
func setStringUserDefaultValue(value : String , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get userDefault Value
func getStringUserDefaultValue(key : UserDefaultKeys) -> String{
    return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
}
///   this func for store Int userDefault Value
func setIntegerUserDefaultValue(value : Int , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get Int userDefault Value
func getIntegerUserDefaultValue(key : UserDefaultKeys) -> Int{
    return UserDefaults.standard.integer(forKey: key.rawValue)
}
///   this func for store Boolean userDefault Value
func setBoolUserDefaultValue(value : Bool , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get Boolean userDefault Value
func getBoolUserDefaultValue(key : UserDefaultKeys) -> Bool{
    return UserDefaults.standard.bool(forKey: key.rawValue)
}
///   this func for store userDefault Value
func setDoubleUserDefaultValue(value : Double , key : UserDefaultKeys){
    UserDefaults.standard.setValue(value, forKey: key.rawValue)
}
///   this func for get userDefault Value
func getDoubleUserDefaultValue(key : UserDefaultKeys) -> Double{
    return UserDefaults.standard.double(forKey: key.rawValue)
}
func valueExists(forKey key: UserDefaultKeys) -> Bool {
    return UserDefaults.standard.value(forKey: key.rawValue) != nil
}

func printLog(string : String? = nil ,data : Any? = nil){
    if isLogPrinted {
        print(string ?? "",data ?? "")
    }
}



func dateToTimeStamp(timeStamp : Double) -> Double{
    let stamp = NSDate().timeIntervalSince1970
    let currentStamp = stamp - timeStamp
    print(currentStamp)
    return currentStamp
}

func setUserDataAsPerView(index : Int ,txtField : UITextField , title : String , txtType : String) {
    var stringToInt = Int()
    let data = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)
    
    if title != "" {
        stringToInt = index
    }
    else{
        stringToInt = Int(title) ?? 0
    }
    if txtType == "gender"{
        let gender = ["Female", "Male"]
        txtField.text = gender[stringToInt]
    }
    else if txtType == "height"{
        txtField.text = title
    }
    else if txtType == "smoke" {
        let smokeData = ["Regularly","Occasionally" ,"Does not Smoke"]
        txtField.text = smokeData[stringToInt]
    }
    else if txtType == "alchohol" {
        let drinkData = ["Regularly","Occasionally" ,"Does not Drink"]
        txtField.text = drinkData[stringToInt]
    }
    else if txtType == "sexual"{
        let str = data?.sexualOrientation?[stringToInt].value
        txtField.text = str
    }
    else if txtType == "fantacy"{
        let str = data?.interestIn?[stringToInt].value
        txtField.text = str
    }
    else if txtType == "lookingFor"{
        let str = data?.lookingFor?[stringToInt].value
        txtField.text = str
    }
    else if txtType == "education"{
        let str = data?.education?[stringToInt].value
        txtField.text = str
    }
    else if txtType == "pets"{
        let str = data?.isPets?[stringToInt].value
        txtField.text = str
    }
    else if txtType == "religion"{
        let str = data?.religion?[stringToInt].value
        txtField.text = str
    }
    
}

func getInterestOrHobbyOfUser(index : [Int]) -> [String]{
//   let arrDta
    let data = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)
    var arrInterst = [String]()
    for i in 0..<index.count {
        arrInterst.append(data?.interest?[index[i] - 1].value ?? "")
    }
    
    return arrInterst
}
