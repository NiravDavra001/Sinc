//
//  HomeViewModel.swift
//  sinc
//
//  Created by mac on 01/03/21.
//

import Foundation
import UIKit

struct GetUserProfile {
    var profileID : [Int?]?
    var profileName : [String?]?
    var profileImage : [String?]?
    var profileOccupation : [String?]?
    var profileDistance : [Float?]?
    var profileAge : [String?]?
}

class HomeViewModel: NSObject {
    
    var userProfile = GetUserProfile()
    var totalPages = 0
    
    func updateLocation(completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.updateCurrentLocation { (response) in
            switch response {
            case .success(let resData):
                print(resData)
                break
            case .failure(let err):
                print(err)
                break
            }
        }
    }
    
    func getAllUserList(pageNo : Int ,params: RegisterDetails,completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.getUserList(pageNo: pageNo, params: params ,completion: { [self] (response)  in
            switch response {
            case .success(let resData) :
                let img = resData.data?.map{$0.image}
                userProfile = GetUserProfile(profileID: resData.data?.map{$0.id}, profileName: resData.data?.map{$0.name}, profileImage : img, profileOccupation: resData.data?.map{$0.profession}, profileDistance: resData.data?.map{$0.distance}, profileAge: resData.data?.map{$0.age} )
                print(userProfile)
                completion(true,"")
            case .failure(let err) :
                completion(false,err.localizedDescription)
            }
        })
    }
    
    func giveLikeDisLikeToUser(params : [String : Any] , completion: @escaping (Bool,String) -> Void){
        NetworkManager.share.callLikeDislikeAPI(params: params) { (response) in
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
