//
//  MyProfileModel.swift
//  sinc
//
//  Created by mac on 08/03/21.
//

import Foundation

struct MyProfileModel : Codable {
    
    let data : MyProfileDetailsModel?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(MyProfileDetailsModel.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}



struct MyProfileDetailsModel : Codable {
    
    let age : String?
    let bio : String?
    let createdAt : String?
    let dateOfBirth : String?
    let education : String?
    let email : String?
    let emailVerifiedAt : String?
    let gender : Int?
    let height : String?
    let id : Int?
    let image : [String]?
    let interest : [String]?
    let interestIn : String?
    let isAlcohol : String?
    let isNew : Int?
    let isPets : String?
    let isSmoke : String?
    let latitude : String?
    let loginType : Int?
    let longitude : String?
    let lookingFor : String?
    let mobile : String?
    let name : String?
    let otp : String?
    let profession : String?
    let region : String?
    let religion : String?
    let role : Int?
    let sexualOrientation : String?
    let updatedAt : String?
    let userVerify : Int?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case bio = "bio"
        case createdAt = "created_at"
        case dateOfBirth = "date_of_birth"
        case education = "education"
        case email = "email"
        case emailVerifiedAt = "email_verified_at"
        case gender = "gender"
        case height = "height"
        case id = "id"
        case image = "image"
        case interest = "interest"
        case interestIn = "interest_in"
        case isAlcohol = "is_alcohol"
        case isNew = "is_new"
        case isPets = "is_pets"
        case isSmoke = "is_smoke"
        case latitude = "latitude"
        case loginType = "login_type"
        case longitude = "longitude"
        case lookingFor = "looking_for"
        case mobile = "mobile"
        case name = "name"
        case otp = "otp"
        case profession = "profession"
        case region = "region"
        case religion = "religion"
        case role = "role"
        case sexualOrientation = "sexual_orientation"
        case updatedAt = "updated_at"
        case userVerify = "user_verify"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent([String].self, forKey: .image)
        interest = try values.decodeIfPresent([String].self, forKey: .interest)
        interestIn = try values.decodeIfPresent(String.self, forKey: .interestIn)
        isAlcohol = try values.decodeIfPresent(String.self, forKey: .isAlcohol)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        isSmoke = try values.decodeIfPresent(String.self, forKey: .isSmoke)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        lookingFor = try values.decodeIfPresent(String.self, forKey: .lookingFor)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        sexualOrientation = try values.decodeIfPresent(String.self, forKey: .sexualOrientation)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
    }
}
