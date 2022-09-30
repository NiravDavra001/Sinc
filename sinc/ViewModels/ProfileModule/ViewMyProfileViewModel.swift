//
//  ViewMyProfileViewModel.swift
//  sinc
//
//  Created by mac on 26/03/21.
//

import Foundation

class ViewMyProfileViewModel: NSObject {
    
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
}
