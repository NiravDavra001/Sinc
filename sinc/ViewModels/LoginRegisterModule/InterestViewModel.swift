//
//  InterestViewModel.swift
//  sinc
//
//  Created by mac on 25/02/21.
//

import Foundation

struct InterstsData {
    var intrestId : Int?
    var intrestName : String?
    var intrestColor : String?
    var isSelected : Bool?
}

class InterestViewModel : NSObject {
    
    func callGetInterestAPI(completion: @escaping (Bool,String) -> Void) {
        NetworkManager.share.getInterstList { (response) in
            switch response {
            case .success(let resData):
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeInterstModel)
                completion(true,"")
            case .failure(let err):
                printLog(string: "error", data: err)
                completion(false , err.localizedDescription)
            }
        }
    }
    
    func callUpdateInterstTagsAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callUpdateInterstTags(params: registerDetails) {(response) in
            switch response{
            case .success(let resData):
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeUpdateProfileModel)
                setBoolUserDefaultValue(value: true, key: .isUserLogin)
                completion(true,"")
            case .failure(let err):
                completion(false,err.localizedDescription)
            }
        }
    }
    
}
