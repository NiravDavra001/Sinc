//
//  LikeMeModel.swift
//  sinc
//
//  Created by mac on 12/05/21.
//

import Foundation

struct LikeMeModel : Codable {
    
    let data : [LikeMeData]?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([LikeMeData].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct LikeMeData : Codable {
    let id : Int?
    let image : String?
    let name : String?
    let secondUserId : Int?
    let status : Int?
    let type : Int?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case name = "name"
        case secondUserId = "second_user_id"
        case status = "status"
        case type = "type"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        secondUserId = try values.decodeIfPresent(Int.self, forKey: .secondUserId)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
}
