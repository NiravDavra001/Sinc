//
//  ConversationIdModel.swift
//  sinc
//
//  Created by mac on 04/05/21.
//

import Foundation

struct ConversationIdModel : Codable {
    
    let data : ConversationId?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ConversationId.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}

struct ConversationId : Codable {
    
    let conversationId : Int?
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversationId"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        conversationId = try values.decodeIfPresent(Int.self, forKey: .conversationId)
    }
}

