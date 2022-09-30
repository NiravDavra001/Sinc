
//
//  UpdateProfileModel.swift
//  sinc
//
//  Created by mac on 18/02/21.
//

import Foundation

struct UpdateProfileModel : Codable {
    
    let data : ProfileData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ProfileData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}

struct ProfileData : Codable {
    
    let bio : String?
    let createdAt : String?
    let dateOfBirth : String?
    let email : String?
    let emailVerifiedAt : String?
    let gender : Int?
    let id : Int?
    let image : [Image]?
    let interest : [Interest]?
    let isAlcohol : Int?
    let isPets : String?
    let isSmoke : Int?
    let loginType : Int?
    let mobile : String?
    let name : String?
    let otp : String?
    let religion : String?
    let role : Int?
    let updatedAt : String?
    let region : String?
    let height : String?
    let latitude : String?
    let longitude : String?
    let age : String?
    let looking_for : String?
    let interest_in : String?
    let sexual_orientation : String?
    let education : String?
    let profession : String?
    let isNew : Int?
    let userVerify : Int?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case bio = "bio"
        case createdAt = "created_at"
        case dateOfBirth = "date_of_birth"
        case email = "email"
        case emailVerifiedAt = "email_verified_at"
        case gender = "gender"
        case id = "id"
        case image = "images"
        case interest = "interest"
        case isAlcohol = "is_alcohol"
        case isPets = "is_pets"
        case isSmoke = "is_smoke"
        case loginType = "login_type"
        case mobile = "mobile"
        case name = "name"
        case otp = "otp"
        case religion = "religion"
        case role = "role"
        case updatedAt = "updated_at"
        case region = "region"
        case height = "height"
        case latitude = "latitude"
        case longitude = "longitude"
        case looking_for = "looking_for"
        case interest_in = "interest_in"
        case sexual_orientation = "sexual_orientation"
        case education = "education"
        case profession = "profession"
        case isNew = "is_new"
        case userVerify = "user_verify"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent([Image].self, forKey: .image)
        interest = try values.decodeIfPresent([Interest].self, forKey: .interest)
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        looking_for = try values.decodeIfPresent(String.self, forKey: .looking_for)
        interest_in = try values.decodeIfPresent(String.self, forKey: .interest_in)
        sexual_orientation = try values.decodeIfPresent(String.self, forKey: .sexual_orientation)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
    }
}

struct Interest : Codable {
    
    let interestId : Int?
    let colorID : String?
    let userId : Int?
    
    enum CodingKeys: String, CodingKey {
        case interestId = "interest_id"
        case userId = "user_id"
        case colorID = "color"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        interestId = try values.decodeIfPresent(Int.self, forKey: .interestId)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        colorID = try values.decodeIfPresent(String.self, forKey: .colorID)
    }
}

struct Image : Codable {
    let id : Int?
    let image : String?
    let sort : Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case sort = "sort"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        sort = try values.decodeIfPresent(Int.self, forKey: .sort)
    }
}
