//
//  AnotherUserProfileModel.swift
//  sinc
//
//  Created by mac on 25/05/21.
//

import Foundation

struct AnotherUserProfileModel : Codable {
    
    let data : AnotherUserData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(AnotherUserData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
    
}


struct AnotherUserData : Codable {
    
    let age : String?
    let bio : String?
    let childrenStatus : String?
    let countryCode : String?
    let createdAt : String?
    let dateOfBirth : String?
    let deletedAt : String?
    let education : String?
    let email : String?
    let emailVerifiedAt : String?
    let gender : Int?
    let height : String?
    let id : Int?
    let images : [AnotherUserImage]?
    let interest : [AnotherUserInterest]?
    let interestIn : String?
    let isAlcohol : Int?
    let isNew : Int?
    let isPets : String?
    let isSmoke : Int?
    let latitude : String?
    let loginId : String?
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
        case childrenStatus = "children_status"
        case countryCode = "country_code"
        case createdAt = "created_at"
        case dateOfBirth = "date_of_birth"
        case deletedAt = "deleted_at"
        case education = "education"
        case email = "email"
        case emailVerifiedAt = "email_verified_at"
        case gender = "gender"
        case height = "height"
        case id = "id"
        case images = "images"
        case interest = "interest"
        case interestIn = "interest_in"
        case isAlcohol = "is_alcohol"
        case isNew = "is_new"
        case isPets = "is_pets"
        case isSmoke = "is_smoke"
        case latitude = "latitude"
        case loginId = "login_id"
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
        print("anothe ruser Profile : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("anothe ruser Profile : ",#line)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("anothe ruser Profile : ",#line)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        print("anothe ruser Profile : ",#line)
        childrenStatus = try values.decodeIfPresent(String.self, forKey: .childrenStatus)
        print("anothe ruser Profile : ",#line)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        print("anothe ruser Profile : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("anothe ruser Profile : ",#line)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        print("anothe ruser Profile : ",#line)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        print("anothe ruser Profile : ",#line)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        print("anothe ruser Profile : ",#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("anothe ruser Profile : ",#line)
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        print("anothe ruser Profile : ",#line)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        print("anothe ruser Profile : ",#line)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        print("anothe ruser Profile : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("anothe ruser Profile : ",#line)
        images = try values.decodeIfPresent([AnotherUserImage].self, forKey: .images)
        print("anothe ruser Profile : ",#line)
        interest = try values.decodeIfPresent([AnotherUserInterest].self, forKey: .interest)
        print("anothe ruser Profile : ",#line)
        interestIn = try values.decodeIfPresent(String.self, forKey: .interestIn)
        print("anothe ruser Profile : ",#line)
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        print("anothe ruser Profile : ",#line)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        print("anothe ruser Profile : ",#line)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        print("anothe ruser Profile : ",#line)
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        print("anothe ruser Profile : ",#line)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        print("anothe ruser Profile : ",#line)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        print("anothe ruser Profile : ",#line)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        print("anothe ruser Profile : ",#line)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        print("anothe ruser Profile : ",#line)
        lookingFor = try values.decodeIfPresent(String.self, forKey: .lookingFor)
        print("anothe ruser Profile : ",#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("anothe ruser Profile : ",#line)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("anothe ruser Profile : ",#line)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        print("anothe ruser Profile : ",#line)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        print("anothe ruser Profile : ",#line)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        print("anothe ruser Profile : ",#line)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        print("anothe ruser Profile : ",#line)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        print("anothe ruser Profile : ",#line)
        sexualOrientation = try values.decodeIfPresent(String.self, forKey: .sexualOrientation)
        print("anothe ruser Profile : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("anothe ruser Profile : ",#line)
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
    }
    
}

struct AnotherUserInterest : Codable {
    
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

struct AnotherUserImage : Codable {
    let image : String?
    let sort : Int?
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
        case sort = "sort"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        sort = try values.decodeIfPresent(Int.self, forKey: .sort)
    }
}
