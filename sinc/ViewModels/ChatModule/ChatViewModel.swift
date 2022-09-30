//
//  ChatViewModel.swift
//  sinc
//
//  Created by mac on 05/05/21.
//

import Foundation
class ChatViewModel: NSObject {
    
    var chatDetails : OldChatModel?
    
    func callGetUserChat(conversationID: Int, pageNumber : Int ,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getOldChat(conversationID: conversationID, pageNumber: pageNumber) { (response) in
            switch response {
            case .success(let resData) :
                print(resData)
                self.chatDetails = resData
                completion(true,"")
                break
            case .failure(let err):
                print(err)
                completion(true,err.localizedDescription)
                break
            }
        }
    }
}
