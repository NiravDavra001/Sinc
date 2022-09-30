//
//  UpdateProfileViewModel.swift
//  sinc
//
//  Created by mac on 18/02/21.
//

import Foundation
import UIKit


class UpdateProfileViewModel : NSObject {
    
    func validateData(viewController : UIViewController) -> Bool{
        var isAllDataValid = true
        let bio = registerDetails.bio?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if registerDetails.gender == nil {
            viewController.showAlert(message: localizedString.selectGender.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.dateOfBirth == nil {
            viewController.showAlert(message: localizedString.selectDateOfBirth.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.height == nil || registerDetails.height == ""{
            viewController.showAlert(message: localizedString.selectheight.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.religion == nil {
            viewController.showAlert(message: localizedString.selectReligion.getLocalizableString())
            isAllDataValid = false
        }
        else if bio == "" || bio == nil{
            viewController.showAlert(message: localizedString.enterBio.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.isSmoke == nil {
            viewController.showAlert(message: localizedString.selectSmoke.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.isAlcohol == nil {
            viewController.showAlert(message: localizedString.selectAlcohol.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.isPets == nil {
            viewController.showAlert(message: localizedString.selectPets.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.sexual_orientation == nil {
            viewController.showAlert(message: localizedString.selectSexualOrientation.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.interest_in == nil {
            viewController.showAlert(message: localizedString.selectInterestIn.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.looking_for == nil {
            viewController.showAlert(message: localizedString.selectWhatLookingFor.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.education == nil {
            viewController.showAlert(message: localizedString.selectEducation.getLocalizableString())
            isAllDataValid = false
        }
        else if registerDetails.profession == nil ||  registerDetails.profession == ""{
            viewController.showAlert(message: localizedString.enterProfession.getLocalizableString())
            isAllDataValid = false
        }
        return isAllDataValid
    }
    
    
    func callUpdateProfileAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callUpdateProfile(params: registerDetails) { (response) in
            switch response {
            case .success(let resData) :
                printLog(string: "res data : ", data: resData)
                UserDefaultManager.share.storeModelToUserDefault(userData: resData.data, key: .storeUpdateProfileModel)
                completion(true,"")
            case .failure(let err) :
                completion(false,err.localizedDescription)
            }
        }
    }
    
}
