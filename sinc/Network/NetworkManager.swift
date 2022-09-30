//
//  NetworkManager.swift
//  sinc
//
//  Created by mac on 06/02/21.
//

import Foundation
import Moya

class NetworkManager : NSObject {
    
    static let share = NetworkManager()
    let provider = MoyaProvider<API>()
    
    
//    In R&D
//    func callGenric<T>(params : [String : Any], completion:@escaping(Result<T,Error>)->Void) where T: Codable {
//        provider.request(.getMyProfile ) { (result) in
//            self.handleDecode(result: result, valueToDecode: completion)
//        }
//    }
    
    func callRegister(params : RegisterDetails,completion:@escaping(Result<RegisterModel,Error>)->Void){
        printLog(string: "register : ",data : params)
        provider.request(.register(params : params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callLogin(params : [String : Any] , completion:@escaping(Result<LoginModel,Error>)->Void){
        provider.request(.login(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callFBLogin(params : [String : Any] , completion:@escaping(Result<RegisterModel,Error>)->Void){
        provider.request(.login(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callUpdateProfile(params : RegisterDetails , completion:@escaping(Result<UpdateProfileModel,Error>)->Void){
        provider.request(.updateUserProfile(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callUpdateImage(params : RegisterDetails,completion:@escaping(Result<UpdateProfileModel,Error>)->Void){
        provider.request(.updateUserImage(params: params)){ (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callUpdateInterstTags(params : RegisterDetails,completion:@escaping(Result<UpdateProfileModel,Error>)->Void){
        provider.request(.updateUserIntrestTags(params: params)){ (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getInterstList(completion:@escaping(Result<GetInterstModel,Error>)->Void){
        provider.request(.getInterstList ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getUserList(pageNo : Int,params : RegisterDetails ,completion:@escaping(Result<SwipableCardModel,Error>)->Void){
        provider.request(.getAllUser(pageNo: pageNo, params: params) ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func updateCurrentLocation(completion:@escaping(Result<UpdateProfileModel,Error>)->Void){
        provider.request(.updateCurrentLocation ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callResendOTPAPI(completion:@escaping(Result<UpdateProfileModel,Error>)->Void){
        provider.request(.resendOTP ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callGetCatagoryAPI(completion:@escaping(Result<UserSeverInfoModel,Error>)->Void){
        provider.request(.getCategory ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callGetUserProfileAPI(completion:@escaping(Result<GetMyProfileModel,Error>)->Void){
        provider.request(.getMyProfile ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getAnoterUsersProfile(userID : Int , completion:@escaping(Result<AnotherUserProfileModel,Error>)->Void){
        provider.request(.getAnotherUserProfile(userID: userID) ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
        
    }
    
    func callDeleteUserAcountAPI(completion:@escaping(Result<DeleteAccountModel,Error>)->Void){
        provider.request(.deleteAccount ) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callEditAndUpdateProfile(params : RegisterDetails , completion:@escaping(Result<UpdateProfileModel,Error>)->Void){
        provider.request(.editUserProfile(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    
    
    func callLikeDislikeAPI(params : [String : Any] , completion:@escaping(Result<LikeModel,Error>)->Void){
        provider.request(.userLikeDisLike(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getUserChatList(completion:@escaping(Result<ChatListModel,Error>)->Void){
        provider.request(.conversationList) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getOldChat(conversationID : Int ,pageNumber : Int , completion:@escaping(Result<OldChatModel,Error>)->Void){
        provider.request(.chatHistory(conversationID: conversationID, pageNumber: pageNumber)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func sendFeedback(feedback: String,completion:@escaping(Result<FeedBackModel,Error>)->Void){
        provider.request(.sendFeedback(feedback: feedback)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func callContactUs(params : [String : Any] ,completion:@escaping(Result<ContactUsModel,Error>)->Void){
        provider.request(.contactUs(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getLikedMeList(completion:@escaping(Result<LikeMeModel,Error>)->Void){
        provider.request(.likedMe) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    func getNewMatchesList(completion:@escaping(Result<NewmatchModel,Error>)->Void){
        provider.request(.newMatch) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    func getConversationID(params : [String : Any] ,completion:@escaping(Result<NewmatchModel,Error>)->Void){
        provider.request(.getConversationID(params: params)) { (result) in
            self.handleDecode(result: result, valueToDecode: completion)
        }
    }
    
    
    func handleDecode<T>(result : Result<Moya.Response,MoyaError>,valueToDecode : @escaping (Result<T,Error>)->Void) where T: Codable {
        printLog(data: T.self)
        switch result {
        case .success(let response):
            do{
                print(try response.mapJSON())
                let json = try JSONDecoder().decode(T.self, from: response.data)
                switch response.statusCode {
                case 200...299:
                    valueToDecode(.success(json)).self
                    break
                case 300...599:
                    let jsonData = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                    let data = handleError(data: jsonData)
                    valueToDecode(.failure(data))
                    break
                default:
                    let jsonData = try JSONDecoder().decode(ErrorModel.self, from: response.data)
                    let data = handleError(data: jsonData)
                    valueToDecode(.failure(data))
                    break
                }
            } catch {
                printLog(string: " Error = \(error.localizedDescription)")
                valueToDecode(.failure(error))
            }
        case .failure(let error):
            printLog(string: " Error = \(error.localizedDescription)")
            valueToDecode(.failure(error))
            break
        }
    }
    
    func handleError(data : ErrorModel?) -> MoyaError {
        let errror = NSError.init(domain: "com.sink", code: 0, userInfo: [NSLocalizedDescriptionKey: data?.message ?? "Something Went Wrong"])
        let error = MoyaError.underlying(errror, nil)
        return error
    }
    
    
}
