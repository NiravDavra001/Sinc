//
//  ContactUsModel.swift
//  sinc
//
//  Created by mac on 10/05/21.
//

import Foundation

struct ContactUsModel : Codable {
    
    let data : ContactUsData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("model : lilne " , #line)
        data = try values.decodeIfPresent(ContactUsData.self, forKey: .data)
        print("model : lilne " , #line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("model : lilne " , #line)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        print("model : lilne " , #line)
    }
    
}

struct ContactUsData : Codable {
    
    let ccBcc : String?
    let createdAt : String?
    let email : String?
    let id : Int?
    let message : String?
    let subject : String?
    let updatedAt : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case ccBcc = "cc_bcc"
        case createdAt = "created_at"
        case email = "email"
        case id = "id"
        case message = "message"
        case subject = "subject"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("model : lilne " , #line)
        ccBcc = try values.decodeIfPresent(String.self, forKey: .ccBcc)
        print("model : lilne " , #line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("model : lilne " , #line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("model : lilne " , #line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("model : lilne " , #line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("model : lilne " , #line)
        subject = try values.decodeIfPresent(String.self, forKey: .subject)
        print("model : lilne " , #line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("model : lilne " , #line)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        print("model : lilne " , #line)
    }
    
}

