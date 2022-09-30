//
//  NetworkConstants.swift
//  sinc
//
//  Created by mac on 06/02/21.
//

import Foundation
import Moya
import UIKit
enum API {
    case login(params : [String : Any])
    case register(params : RegisterDetails)
    case updateUserProfile(params : RegisterDetails)
    case updateUserImage(params : RegisterDetails)
    case updateUserIntrestTags(params : RegisterDetails)
    case getInterstList
    case getAllUser(pageNo : Int,params : RegisterDetails)
    case updateCurrentLocation
    case resendOTP
    case getCategory
    case getMyProfile
    case deleteAccount
    case editUserProfile(params : RegisterDetails)
    case userLikeDisLike(params : [String:Any])
    case getAnotherUserProfile(userID : Int)
    
    case conversationList
    case getConversationID(params : [String:Any])
    
    case chatHistory(conversationID: Int, pageNumber: Int)
    case requestForChat(requestID: Int, status: Int)
    
    case sendFeedback(feedback : String)
    case contactUs(params : [String : Any])
    
    case newMatch
    case likedMe
}

extension API : TargetType {
    
    var headers: [String : String]? {
        switch self {
        case .updateUserImage, .updateUserProfile, .getInterstList ,.updateUserIntrestTags, .getAllUser,.updateCurrentLocation ,.resendOTP ,.getCategory ,.getMyProfile, .deleteAccount ,.editUserProfile  ,.conversationList , .chatHistory , .sendFeedback ,.contactUs , .likedMe , .newMatch , .userLikeDisLike ,.getConversationID , .getAnotherUserProfile:
            return ["Content-Type":"multipart/form-data", "Authorization" : getStringUserDefaultValue(key: .appToken)]
            
        default :
            return ["Content-Type":"application/json"]
        }
    }
    
    var baseURL: URL {
        return URL(string: "http://13.235.125.148/api/v1")!
    }
    
    var path: String {
//        check for this API
//        verify , block
        switch self {
        case .login:
            return "/login"
        case .register:
            return "/register"
        case .updateUserProfile, .updateUserImage, .updateUserIntrestTags:
            return "/profile"
        case .getInterstList:
            return "/interest"
        case .getAllUser:
            return "/users"
        case .updateCurrentLocation:
            return "/location"
        case .resendOTP:
            return "/resend-otp"
        case .getCategory:
            return "/category"
        case .getMyProfile:
            return "/profile"
        case .deleteAccount:
            return "/user/\(userID ?? -1)"
        case .editUserProfile:
            return "/profile"
        case .chatHistory(let conversationID, let pageNumber):
            print("in API call : ",pageNumber)
            print("in API call conversationID : ",conversationID)
            return "/conversation/chat/\(conversationID)"
//                ?page=\(pageNumber)
        case .requestForChat:
            return "/chat/request"
        case .userLikeDisLike:
            return "/userlike"
        case .conversationList:
            return "/conversation"
        case .sendFeedback:
            return "/feedback"
        case .contactUs:
            return "/contact"
        case .newMatch:
            return "/match"
        case .likedMe:
            return "/like-me"
        case .getConversationID:
            return "/getConversationId"
        case .getAnotherUserProfile(let userID):
            return "/user-profile/\(userID)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        case .register, .updateUserProfile, .updateUserImage, .updateUserIntrestTags, .editUserProfile:
            return .post
        case .getInterstList , .chatHistory:
            return .get
        case .getAllUser:
            return .post
        case .updateCurrentLocation:
            return .post
        case .resendOTP:
            return .post
        case.getCategory:
            return .get
        case .getMyProfile:
            return .get
        case .deleteAccount:
            return .delete
        
        case .requestForChat:
            return .post
        case .userLikeDisLike:
            return .post
        case .conversationList:
            return .get
        case .sendFeedback:
            return .post
        case .contactUs :
            return .post
        case .newMatch:
            return .get
        case .likedMe:
            return .get
        case .getConversationID:
            return .post
        case .getAnotherUserProfile:
            return .post
        }
        
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .register(let params):
            let dict = ["login_id" : params.login_id ?? "","password" : params.password ?? "","login_type" : params.login_type ?? 0,"religion" : params.region ?? "","name" : params.name ?? ""] as [String : Any]
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
            
        case .updateUserProfile(let params) :
            
            var dict = [String: Any]()
            
            if let bio = params.bio, bio != ""{
                dict["bio"] = bio
            }
            if let dateOfBirth = params.dateOfBirth {
                dict["date_of_birth"] = dateOfBirth
            }
            if let gender = params.gender{
                dict["gender"] = gender
            }
            if let isAlcohol = params.isAlcohol {
                dict["is_alcohol"] = isAlcohol
            }
            if let isPets = params.isPets , isPets != ""{
                dict["is_pets"] = isPets
            }
            if let isSmoke = params.isSmoke {
                dict["is_smoke"] = isSmoke
            }
            if let religion = params.religion {
                dict["religion"] = religion
            }
            if let height = params.height , height != ""{
                dict["height"] = height
            }
            if let looking_for = params.looking_for , looking_for != ""{
                dict["looking_for"] = looking_for
            }
            if let interest_in = params.interest_in , interest_in != ""{
                dict["interest_in"] = interest_in
            }
            if let sexual_orientation = params.sexual_orientation , sexual_orientation != ""{
                dict["sexual_orientation"] = sexual_orientation
            }
            if let education = params.education , education != ""{
                dict["education"] = education
            }
            if let name = params.name , name != ""{
                dict["name"] = name
            }
            if let profession = params.profession , profession != ""{
                dict["profession"] = profession
            }
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
            
            
        case .updateUserImage(let params):
            var multipartData = [MultipartFormData]()
            let Provience1 = MultipartFormData.init(provider: .data(params.image1 ?? Data()), name: "image1", fileName: "CapImage.jpg", mimeType: "image/jpeg")
            multipartData.append(Provience1)
            
            return .uploadMultipart(multipartData)
            
        case .updateUserIntrestTags(params: let params):
            var dict = [String:Any]()
            dict["interest"] = params.interest ?? ""
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
            
        case .getInterstList:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
            
        case .getAllUser(let pageNo,let params):
            var dict = [String : Any]()
            if let minHeight = params.minHeight{
                dict["min_height"] = minHeight
            }
            if let maxheight = params.maxHeight {
                dict["max_height"] = maxheight
            }
            if let minAge = params.minAge {
                dict["min_age"] = minAge
            }
            if let maxAge = params.maxAge {
                dict["max_age"] = maxAge
            }
            if let religion = params.religion {
                dict["religion"] = religion
            }
            if let pets = params.isPets {
                dict["is_pets"] = pets
            }
            if let smoke = params.isSmoke{
                dict["smoke"] = smoke
            }
            if let alcohol = params.isAlcohol {
                dict["is_alcohol"] = alcohol
            }
            if let relation = params.looking_for {
                dict["looking_for"] = relation
            }
            if let myFantacy = params.interest_in {
                dict["interest_in"] = myFantacy
            }
            if let sexualOrientation = params.sexual_orientation {
                dict["sexual_orientation"] = sexualOrientation
            }
            dict["page"] = pageNo
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
            
        case .updateCurrentLocation:
            var dict = [String : Any]()
            dict["latitude"] = currentLatitued
            dict["longitude"] = currentLongitued
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
        case .resendOTP:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .getCategory:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .getMyProfile:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .deleteAccount:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
            
        case .editUserProfile(let params):
            var multipartData = [MultipartFormData]()
            if let bio = params.bio, bio != ""{
                let Provience = MultipartFormData.init(provider: .data(bio.data(using: String.Encoding.utf8) ?? Data()), name: "bio")
                multipartData.append(Provience)
            }
            if let dateOfBirth = params.dateOfBirth {
                let Provience = MultipartFormData.init(provider: .data("\(dateOfBirth)".data(using: String.Encoding.utf8) ?? Data()), name: "date_of_birth")
                multipartData.append(Provience)
            }
            if let gender = params.gender{
                let Provience = MultipartFormData.init(provider: .data("\(gender)".data(using: String.Encoding.utf8) ?? Data()), name: "gender")
                multipartData.append(Provience)
            }
            if let isAlcohol = params.isAlcohol {
                let Provience = MultipartFormData.init(provider: .data("\(isAlcohol)".data(using: String.Encoding.utf8) ?? Data()), name: "is_alcohol")
                multipartData.append(Provience)
            }
            if let isPets = params.isPets , isPets != ""{
                let Provience = MultipartFormData.init(provider: .data(isPets.data(using: String.Encoding.utf8) ?? Data()), name: "is_pets")
                multipartData.append(Provience)
            }
            if let isSmoke = params.isSmoke {
                let Provience = MultipartFormData.init(provider: .data("\(isSmoke)".data(using: String.Encoding.utf8) ?? Data()), name: "is_smoke")
                multipartData.append(Provience)
                
            }
            if let religion = params.religion {
                let Provience = MultipartFormData.init(provider: .data("\(religion)".data(using: String.Encoding.utf8) ?? Data()), name: "religion")
                multipartData.append(Provience)
            }
            if let height = params.height , height != ""{
                let Provience = MultipartFormData.init(provider: .data(height.data(using: String.Encoding.utf8) ?? Data()), name: "height")
                multipartData.append(Provience)
            }
            if let looking_for = params.looking_for , looking_for != ""{
                let Provience = MultipartFormData.init(provider: .data(looking_for.data(using: String.Encoding.utf8) ?? Data()), name: "looking_for")
                multipartData.append(Provience)
            }
            if let interest_in = params.interest_in , interest_in != "" {
                let Provience = MultipartFormData.init(provider: .data(interest_in.data(using: String.Encoding.utf8) ?? Data()), name: "interest_in")
                multipartData.append(Provience)
            }
            if let sexual_orientation = params.sexual_orientation , sexual_orientation != ""{
                let Provience = MultipartFormData.init(provider: .data(sexual_orientation.data(using: String.Encoding.utf8) ?? Data()), name: "sexual_orientation")
                multipartData.append(Provience)
            }
            if let education = params.education , education != ""{
                let Provience = MultipartFormData.init(provider: .data(education.data(using: String.Encoding.utf8) ?? Data()), name: "education")
                multipartData.append(Provience)
            }
            if let name = params.name , name != ""{
                let Provience = MultipartFormData.init(provider: .data(name.data(using: String.Encoding.utf8) ?? Data()), name: "name")
                multipartData.append(Provience)
            }
            if let profession = params.profession , profession != ""{
                let Provience = MultipartFormData.init(provider: .data(profession.data(using: String.Encoding.utf8) ?? Data()), name: "profession")
                multipartData.append(Provience)
            }
            if let userInterest = params.interest , userInterest != "" {
                let Provience = MultipartFormData.init(provider: .data(userInterest.data(using: String.Encoding.utf8) ?? Data()), name: "interest")
                multipartData.append(Provience)
            }
            if let imageData = params.image1 ,imageData != Data() {
                let Provience = MultipartFormData.init(provider: .data(imageData), name: "image1", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(Provience)
            }
            if let imageData = params.image2,imageData != Data(){
                let Provience = MultipartFormData.init(provider: .data(imageData), name: "image2", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(Provience)
            }
            if let imageData = params.image3,imageData != Data() {
                let Provience = MultipartFormData.init(provider: .data(imageData), name: "image3", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(Provience)
            }
            if let imageData = params.image4,imageData != Data() {
                let Provience = MultipartFormData.init(provider: .data(imageData), name: "image4", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(Provience)
            }
            if let imageData = params.image5,imageData != Data() {
                let Provience = MultipartFormData.init(provider: .data(imageData), name: "image5", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(Provience)
            }
            if let imageData = params.image6,imageData != Data() {
                let Provience = MultipartFormData.init(provider: .data(imageData), name: "image6", fileName: "image.jpg", mimeType: "image/jpeg")
                multipartData.append(Provience)
            }
            
            if multipartData.isEmpty {
                return .requestPlain
            }
            return .uploadCompositeMultipart(multipartData, urlParameters: [ : ])
            
        case .chatHistory(let conversationID,let pageNumber):
            var dict = [String : Any]()
            dict.removeAll()
            dict["page"] = pageNumber
            return .requestParameters(parameters: dict, encoding: URLEncoding.queryString)
            
        case .requestForChat(let requestID, let status):
            let authParams = ["request_user_id":requestID,
                              "status":status]
            var parameterData = Data()
            do {
                parameterData = try JSONSerialization.data(withJSONObject: authParams, options: [])
            } catch let error {
                print("Parameters not converted with error: \(error)")
            }
            return .requestData(parameterData)
        case .userLikeDisLike(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .conversationList:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .sendFeedback(let feedback):
            let dic = ["feedback" : feedback]
            return .requestParameters(parameters: dic, encoding: URLEncoding.queryString)
        case .contactUs(let params):
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .newMatch:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .likedMe:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        case .getConversationID(let params):
            
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .getAnotherUserProfile:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
}
