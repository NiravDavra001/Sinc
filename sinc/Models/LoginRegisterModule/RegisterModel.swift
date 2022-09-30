//
//  RegisterModel.swift
//  sinc
//
//  Created by mac on 12/02/21.
//

import Foundation


struct RegisterModel : Codable {
    let data : RegisterData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        print("line no : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("line no : ",#line)
        data = try values.decodeIfPresent(RegisterData.self, forKey: .data)
        print("line no : ",#line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("line no : ",#line)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        print("line no : ",#line)
    }
}

struct RegisterData : Codable {
    let token : String?
    let user : RegisterUserData?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        print("line no : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("line no : ",#line)
        user = try values.decodeIfPresent(RegisterUserData.self, forKey: .user)
        print("line no : ",#line)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        print("line no : ",#line)
    }
}

struct RegisterUserData : Codable {
    let createdAt : String?
    let id : Int?
    let loginType : String?
    let mobile : String?
    let email : String?
    let name : String?
    let region : String?
    let updatedAt : String?
    let latitude : String?
    let longitude : String?
    let otp : Int?
    let loginId : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case loginType = "login_type"
        case mobile = "mobile"
        case name = "name"
        case email = "email"
        case region = "region"
        case updatedAt = "updated_at"
        case latitude = "latitude"
        case longitude = "longitude"
        case otp = "otp"
        case loginId = "login_id"
    }
    
    init(from decoder: Decoder) throws {
        print("line no : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("line no : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("line no : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("line no : ",#line)
        loginType = try values.decodeIfPresent(String.self, forKey: .loginType)
        print("line no : ",#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("line no : ",#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("line no : ",#line)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("line no : ",#line)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        print("line no : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("line no : ",#line)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        print("line no : ",#line)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        print("line no : ",#line)
        otp =  try values.decodeIfPresent(Int.self, forKey: .otp)
        print("line no : ",#line)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        print("line no : ",#line)
    }
}
