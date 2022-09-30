//
//  RegisterViewModel.swift
//  sinc
//
//  Created by mac on 16/02/21.
//

import Foundation

class RegisterViewModel : NSObject {
    
    
    func callRegisterAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callRegister(params: registerDetails) { (response) in
            switch response {
            case .success(let resData) :
                if resData.data?.user?.email != "" || resData.data?.user?.email != nil{
                    setStringUserDefaultValue(value: resData.data?.user?.email ?? "", key: .loginID)
                }
                else{
                    setStringUserDefaultValue(value: resData.data?.user?.mobile ?? "", key: .loginID)
                }
                setIntegerUserDefaultValue(value: resData.data?.user?.otp ?? 0, key: .OTP)
                setIntegerUserDefaultValue(value: resData.data?.user?.id ?? 0, key: .userID)
                setStringUserDefaultValue(value: resData.data?.token ?? "", key: .appToken)
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeRegisterModel)
                
                completion(true,"")
            case .failure(let err) :
                completion(false, err.localizedDescription)
            }
        }
    }
}
