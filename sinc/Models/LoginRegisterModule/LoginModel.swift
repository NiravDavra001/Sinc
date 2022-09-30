//
//  LoginModel.swift
//  sinc
//
//  Created by mac on 12/02/21.
//

import Foundation

struct LoginModel : Codable{
    let data : User?
    let message : String?
    let status : Int?
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(User.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct User : Codable {
    let token : String?
    let user : UserData?
    enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        user = try values.decodeIfPresent(UserData.self, forKey: .user)
    }
}

struct UserData:Codable {
    let age : String?
    let bio : String?
    let createdAt : String?
    let dateOfBirth : String?
    let email : String?
    let emailVerifiedAt : String?
    let gender : Int?
    let height : String?
    let id : Int?
    let image : [UserImages]?
    let interest : [UserIntrests]?
    let isAlcohol : Int?
    let isPets : String?
    let isSmoke : Int?
    let loginType : Int?
    let mobile : String?
    let name : String?
    let otp : String?
    let region : String?
    let religion : String?
    let role : Int?
    let updatedAt : String?
    let childrenStatus : String?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case bio = "bio"
        case createdAt = "created_at"
        case dateOfBirth = "date_of_birth"
        case email = "email"
        case emailVerifiedAt = "email_verified_at"
        case gender = "gender"
        case height = "height"
        case id = "id"
        case image = "image"
        case interest = "interest"
        case isAlcohol = "is_alcohol"
        case isPets = "is_pets"
        case isSmoke = "is_smoke"
        case loginType = "login_type"
        case mobile = "mobile"
        case name = "name"
        case otp = "otp"
        case region = "region"
        case religion = "religion"
        case role = "role"
        case updatedAt = "updated_at"
        case childrenStatus = "children_status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent([UserImages].self, forKey: .image)
        interest = try values.decodeIfPresent([UserIntrests].self, forKey: .interest)
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        childrenStatus = try values.decodeIfPresent(String.self, forKey: .childrenStatus)
    }
}

struct UserImages : Codable{
    var image : String?
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
}

struct UserIntrests : Codable{
    let categoryId : Int?
    let id : Int?
    let interestId : Int?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case id = "id"
        case interestId = "interest_id"
        case userId = "user_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try values.decodeIfPresent(Int.self, forKey: .categoryId)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        interestId = try values.decodeIfPresent(Int.self, forKey: .interestId)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
    }
}


