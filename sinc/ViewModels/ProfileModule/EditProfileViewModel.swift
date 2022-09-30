//
//  EditProfileViewModel.swift
//  sinc
//
//  Created by mac on 05/04/21.
//

import Foundation

class EditProfileViewModel: NSObject {
    
    var myProfile : GetMyProfileModel?
        
    func callGetMyProfileDetailsAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callGetUserProfileAPI { (result) in
            switch result {
            case .success(let resData) :
                print(resData)
                self.myProfile = resData
                completion(true,"")
                break
            case .failure(let err) :
                print(err)
                completion(false,err.localizedDescription)
                break
            }
        }
    }
    
    func callEditAndUpdateProfile(completion: @escaping (Bool,String) -> Void){
        
        NetworkManager.share.callEditAndUpdateProfile(params: registerDetails) { (response) in
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
