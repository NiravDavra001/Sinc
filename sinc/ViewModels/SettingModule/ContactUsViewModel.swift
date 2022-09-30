//
//  ContactUsViewModel.swift
//  sinc
//
//  Created by mac on 10/05/21.
//

import Foundation
class ContactUsViewModel: NSObject {
    func callContactUSAPI(params : [String : Any],completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callContactUs(params: params) { (result) in
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
