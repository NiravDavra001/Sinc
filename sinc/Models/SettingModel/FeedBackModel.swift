//
//  FeedBackModel.swift
//  sinc
//
//  Created by mac on 08/05/21.
//

import Foundation

struct FeedBackModel : Codable {
    
    let data : FeedBackData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(FeedBackData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct FeedBackData : Codable {
    
    let createdAt : String?
    let feedback : String?
    let id : Int?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case feedback = "feedback"
        case id = "id"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        feedback = try values.decodeIfPresent(String.self, forKey: .feedback)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
    
}
