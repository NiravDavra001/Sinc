//
//  SettingViewModel.swift
//  sinc
//
//  Created by mac on 25/03/21.
//

import Foundation

class SettingViewModel: NSObject {
    
    
    func callDeleteAccountAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callDeleteUserAcountAPI { (result) in
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
    
}
