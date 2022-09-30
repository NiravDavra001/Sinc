//
//  LoginViewModel.swift
//  sinc
//
//  Created by mac on 18/02/21.
//

import Foundation

class LoginViewModel : NSObject {
    func callLoginAPI(params : [String : Any] , completion: @escaping (LoginModel?,Bool,String) -> Void){
        
        NetworkManager.share.callLogin(params: params) { (response) in
            switch response {
            case .success(let resData) :
                printLog(data: resData)
                setStringUserDefaultValue(value: resData.data?.token ?? "", key: .appToken)
                setIntegerUserDefaultValue(value: resData.data?.user?.id ?? 0, key: .userID)
                
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeLoginModel)
                completion(resData,true,"")
                
            case .failure(let err) :
                completion(nil, false , err.localizedDescription)
                printLog(string: "error : ", data: err)
            }
        }
    }
}
