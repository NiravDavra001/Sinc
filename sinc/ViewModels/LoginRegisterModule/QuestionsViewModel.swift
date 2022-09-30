//
//  QuestionsViewModel.swift
//  sinc
//
//  Created by mac on 06/03/21.
//

import Foundation

class QuestionsViewModel : NSObject {
    func calFBLoginAPI(params : [String : Any] , completion: @escaping (RegisterModel?,Bool,String) -> Void){
        
        NetworkManager.share.callFBLogin(params: params) { (response) in
            switch response {
            case .success(let resData) :
                printLog(data: resData)
                setStringUserDefaultValue(value: resData.data?.token ?? "", key: .appToken)
                UserDefaultManager.share.storeModelToUserDefault(userData: resData, key: .storeRegisterModel)
                completion(resData,true,"")
                
            case .failure(let err) :
                completion(nil, false , err.localizedDescription)
                printLog(string: "error : ", data: err)
            }
        }
    }
}
