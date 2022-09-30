//
//  ViewProfileViewModel.swift
//  sinc
//
//  Created by mac on 08/03/21.
//

import Foundation

class ViewProfileViewModel: NSObject {
    
//    NetworkManager.share
    
    var userData : AnotherUserProfileModel?
    
    func callGetUserProfile (completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callGetUserProfileAPI { (result) in
            switch result {
            case .success(let resData) :
                print(resData)
                completion(true,"")
                break
            case .failure(let err) :
                print(err)
                completion(false,err.localizedDescription)
                break
            }
        }
    }
    
    func callAnotherUserProfile(userID : Int ,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getAnoterUsersProfile(userID: userID) { (result) in
            switch result {
            case .success(let resData) :
                print(resData)
                self.userData = resData
                completion(true,"")
                break
            case .failure(let err) :
                print(err)
                completion(false,err.localizedDescription)
                break
            }
        }
    }
    
    

}
