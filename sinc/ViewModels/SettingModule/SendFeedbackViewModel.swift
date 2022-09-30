//
//  SendFeedbackViewModel.swift
//  sinc
//
//  Created by mac on 08/05/21.
//

import Foundation
class SendFeedbackViewModel: NSObject {
    func sendFeedbackToserver(feedback: String,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.sendFeedback(feedback: feedback) { (result) in
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
