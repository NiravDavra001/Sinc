//
//  SendOtpViewModel.swift
//  sinc
//
//  Created by mac on 06/03/21.
//

import Foundation


class SendOtpViewModel : NSObject {
    
    func callResendOTP(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callResendOTPAPI { (result) in
            switch result {
            case .success(let resData):
                setStringUserDefaultValue(value: resData.data?.otp ?? "", key: .OTP)
                completion(true,"")
            case .failure(let err):
                completion(false,err.localizedDescription)
             
            }
        }
    }
    
    func callGetCatagoryAPI(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callGetCatagoryAPI { (result) in
            switch result {
            case .success(let resData):
                print(resData)
                UserDefaultManager.share.storeModelToUserDefault(userData: resData.data, key: .storeUserPersonalInfo)
                completion(true ,"")
            case .failure(let err):
                completion(false ,err.localizedDescription)
            }
        }
        
    }
    
}


