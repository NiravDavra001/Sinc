//
//  LikeModel.swift
//  sinc
//
//  Created by mac on 04/05/21.
//

import Foundation


struct LikeModel : Codable {
    
    let data : LikeDislikeData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(LikeDislikeData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct LikeDislikeData : Codable {
    
    let createdAt : String?
    let id : Int?
    let secondUserId : Int?
//    let type : Int?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case secondUserId = "second_user_id"
//        case type = "type"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        print("like mode  : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("like mode  : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("like mode  : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("like mode  : ",#line)
        secondUserId = try values.decodeIfPresent(Int.self, forKey: .secondUserId)
        print("like mode  : ",#line)
//        type = try values.decodeIfPresent(Int.self, forKey: .type)
//        print("like mode  : ",#line,type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("like mode  : ",#line)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
}
