//
//  enums.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import Foundation
import UIKit

enum FontName : String {
    case Bold                                                          = "Inter-Bold"
    case Light                                                         = "Inter-Light"
    case Thin                                                          = "Inter-Thin"
    case Medium                                                        = "Inter-Medium"
    case Regular                                                       = "Inter-Regular"
    case ExtraBold                                                     = "Inter-ExtraBold"
    case ExtraLight                                                    = "Inter-ExtraLight"
    case Black                                                         = "Inter-Black"
    case SemiBold                                                      = "Inter-SemiBold"
}

enum FontSize : CGFloat {
    case Size_12                                                       = 12.0
    case Size_14                                                       = 14.0
    case Size_16                                                       = 16.0
    case Size_18                                                       = 18.0
    case Size_20                                                       = 20.0
    case Size_24                                                       = 24.0
    case Size_28                                                       = 28.0
    case Size_32                                                       = 32.0
}

enum ViewControllerIdentifiers : String {
    case  LoginVC                                                      = "LoginViewController"
    case  NewLoginVC                                                   = "NewLoginViewController"
    case  SendOtpVC                                                    = "SendOtpViewController"
    case  QuestionVC                                                   = "QuestionViewController"
    case  SignUpVC                                                     = "SignUpViewController"
    case  ErrorMsgVC                                                   = "ErrorMessageViewController"
    case  TellAboutYouVC                                               = "TellAboutYouViewController"
    case  UpdatePhotosVC                                               = "UpdatePhotosViewController"
    case  InterestsVC                                                  = "InterestsViewController"
    case  homeVC                                                       = "HomeViewController"
    case  PremiumFeaturesPopupVC                                       = "PremiumFeaturesPopupViewController"
    case  PremiumFeaturesVC                                            = "premiumFeaturesViewController"
    case  TabbarVC                                                     = "TabbarViewController"
    case  settingVC                                                    = "SettingViewController"
    case  viewProfileVC                                                = "ViewProfileViewController"
    case  feedbackVC                                                   = "FeedbackViewController"
    case  contactUsVC                                                  = "ContactUsViewController"
    case  ChatMessagesVC                                               = "ChatMessagesViewController"
    case  MyProfileVC                                                  = "MyProfileViewController"
    case  EditProfileVC                                                = "EditProfileViewController"
    case  FiltersVC                                                    = "FiltersViewController"
    case  ViewMyProfileVC                                              = "ViewMyProfileViewController"
    case  SelectInstrestsVC                                            = "SelectInstrestsViewController"
    case  ShowMessagesVC                                               = "ShowMessagesViewController"
    
    
    
}

enum StoryBoardIdentifiers : String {
    case  Main                                                         = "Main"
    case  Home                                                         = "Home"
    case  Profile                                                      = "Profile"
    case  Setting                                                      = "Settings"
    case  Message                                                      = "Message"
}

enum localizedString : String {
    case enterName                                                     = "enter_user_name"
    case enterPassword                                                 = "enter_user_password"
    case validPassword                                                 = "enter_valid_password"
    case enterConfirmPasswrod                                          = "enter_user_confirm_password"
    case enterEmailPhone                                               = "enter_email_phone"
    case validEmail                                                    = "valid_email"
    case validPhone                                                    = "valid_phone"
    case enterEmail                                                    = "enter_email"
    case enterPhone                                                    = "enter_phone"
    case matchPassword                                                 = "enter_match_password"
    case confirmationMail                                              = "confirmation_mail"
    case loginOtherWay                                                 = "login_other_way"
    case resendIn                                                      = "resend_in"
    case haveChild                                                     = "have_child"
    case wantChild                                                     = "want_child"
    case notSure                                                       = "not_sure"
    case questionPets                                                  = "questions_pets"
    case questionDrink                                                 = "questions_drink"
    case questionSmoke                                                 = "questions_smoke"
    case selectDrink                                                 = "select_drink"
    
    
    case questionLookingFor                                            = "questions_looking_for"
    case Education                                                     = "Education"
    case wantToSee                                                     = "want_to_see"
    case sexualType                                                    = "sexual_type"
    case enterProfession                                               = "enter_profession"
    
    case religion                                                      = "questions_religion"
    case validOTP                                                      = "valid_otp"
    case selectGender                                                  = "select_gender"
    case selectDateOfBirth                                             = "select_birthdate"
    case selectheight                                                  = "select_height"
    case selectReligion                                                = "select_religion"
    case selectSmoke                                                   = "select_smoke"
    case selectAlcohol                                                 = "select_alchohol"
    case selectPets                                                    = "select_pets"
    case enterBio                                                      = "enter_bio"
    case insertPicture                                                 = "insert_picture"
    
    case selectWhatLookingFor                                          = "select_looking_for"
    case selectEducation                                               = "select_education"
    case selectSexualOrientation                                       = "select_sexual_orientation"
    case selectInterestIn                                              = "select_interest_in"
    
    case wantPremium                                                    = "want_see_go_premium"
    case enableNotification                                             = "enable_notificaton"
    case newMatch                                                       = "new_match"
    case newMessage                                                     = "new_message"
    case notification                                                   = "notification"
    case feedback                                                       = "feedback"
    case contactUs                                                      = "contact_us"
    case rateUs                                                         = "rate_us"
    case Share                                                          = "share"
    case deletedAccount                                                 = "deleted_account"
    case logOut                                                         = "log_out"
    case location                                                       = "location"
    case sureLogout                                                     = "sure_logout_accunt"
    case sureDelete                                                     = "sure_delete_account"
    
    case enterFeedback                                                     = "enter_feedback"
    
    func getLocalizableString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

enum UserDefaultKeys : String {
    case isUserLogin                                                   = "isUserLogin"
    case isUserFirstTime                                               = "isUserFirstTime"
    case loginID                                                       = "loginID"
    case userName                                                      = "userName"
    case appToken                                                      = "appToken"
    case region                                                        = "region"
    case userID                                                        = "userID"
    case userReligion                                                  = "religion"
    case userGender                                                    = "userGender"
    case userBio                                                       = "userBio"
    case userAlcohol                                                   = "userAlcohol"
    case userSmoke                                                     = "userSmoke"
    case userPets                                                      = "userPets"
    case userDateOfBirth                                               = "userDateOfBirth"
    case userHeight                                                    = "userHeight"
    case userPic                                                       = "userPicture"
    case userLastLatitude                                              = "userLastLatitude"
    case userLastLongitude                                             = "userLastLongitude"
    case OTP                                                           = "OTP"
    case fbLoginID                                                     = "FBLoginID"
    case fbName                                                        = "FBName"
    case fbEmail                                                       = "FBEmail"
    case isFbLogin                                                     = "isFbLogin"
    case wantChild                                                     = "WantChild"
    case isCardUnderSwipe                                              = "isCardUnderSwipe"
}

enum UserDefaultModelKeys : String{
    case storeLoginModel                                               = "StoreLoginModel"
    case storeRegisterModel                                            = "StoreRegisterModel"
    case storeUpdateProfileModel                                       = "StoreUpdateProfileModel"
    case storeInterstModel                                             = "StoreInterstModel"
    case storeUserPersonalInfo                                         = "storeUserPersonalInfo"
    case storeUserFilterData                                           = "storeUserFilterData"
    case storeMyIntrests                                               = "storeMyIntrests"
}

enum loginMode : String{
    case phone                                                         = "Phone"
    case email                                                         = "Email"
}

enum profileDetails : String{
    case smoking                                                       = "smoking"
    case drinking                                                      = "drinking"
    case pets                                                          = "pets"
    case religion                                                      = "religion"
    case sexual                                                        = "sexual"
    case education                                                     = "education"
    case wantGender                                                    = "wantGender"
    case relationShipStatus                                            = "relationShipStatus"
}

enum loginType : Int {
    case emailPhone                                                    = 1
    case facebook                                                      = 2
    case google                                                        = 3
    case apple                                                         = 4
}
