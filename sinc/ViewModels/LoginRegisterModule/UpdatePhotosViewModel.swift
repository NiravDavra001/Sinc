//
//  UpdatePhotosViewModel.swift
//  sinc
//
//  Created by mac on 24/02/21.
//

import Foundation
class UpdatePhotosViewModel : NSObject {
    
    func callUpdateImageAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callUpdateImage(params: registerDetails) { (response) in
            switch response {
            case.success(let resData):
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeUpdateProfileModel)
                completion(true,"")
                break
            case .failure(let err):
                printLog(string: "error : ", data: err)
                break
            }
        }
    }
}
