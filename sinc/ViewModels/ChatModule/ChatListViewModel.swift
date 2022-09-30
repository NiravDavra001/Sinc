//
//  ChatListViewModel.swift
//  sinc
//
//  Created by mac on 05/05/21.
//

import Foundation

class ChatListViewModel: NSObject {
    var chatDetails : ChatListModel?
    var likedMeList : LikeMeModel?
    var newMatchesList : NewmatchModel?
    
    func callGetUserListForChat(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getUserChatList { (response) in
            switch response {
            case .success(let resData) :
                self.chatDetails = resData
                completion(true,"")
                break
            case .failure(let err):
                completion(false,err.localizedDescription)
                break
            }
        }
    }
    
    func getLikeME(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getLikedMeList { (response) in
            switch response {
            case .success(let resData) :
                self.likedMeList = resData
                completion(true,"")
                break
            case .failure(let err):
                completion(false,err.localizedDescription)
                break
            }
        }
    }
    func getNewMatches(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getNewMatchesList { (response) in
            switch response {
            case .success(let resData) :
                self.newMatchesList = resData
                completion(true,"")
                break
            case .failure(let err):
                completion(false,err.localizedDescription)
                break
            }
        }
    }
    
    func getConversationID(params : [String : Any] , completion: @escaping (Bool,String) -> Void) {
        NetworkManager.share.getConversationID(params: params) { (response) in
            switch response {
            case .success(let resData):
                print("like dislike data : " , resData)
                completion(true,"")
                break
            case .failure(let error):
                completion(false,error.localizedDescription)
                break
            }
        }
    }
    
}
