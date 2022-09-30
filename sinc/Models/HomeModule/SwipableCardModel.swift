//
//  SwipableCardModel.swift
//  sinc
//
//  Created by mac on 01/03/21.
//

import Foundation

struct SwipableCardModel : Codable {
    let data : [CardUserDataModel]?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CardUserDataModel].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct CardUserDataModel : Codable {
    let age : String?
    let bio : String?
    let childrenStatus : String?
    let countryCode : String?
    let dateOfBirth : String?
    let deletedAt : String?
    let distance : Float?
    let education : String?
    let email : String?
    let gender : Int?
    let height : String?
    let id : Int?
    let image : String?
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
    let password : String?
    let profession : String?
    let region : String?
    let religion : String?
    let role : Int?
    let sexualOrientation : String?
    let sort : String?
    let updatedAt : String?
    let userId : Int?
    let userVerify : Int?
    
    enum CodingKeys: String, CodingKey {
        case age = "age"
        case bio = "bio"
        case childrenStatus = "children_status"
        case countryCode = "country_code"
        case dateOfBirth = "date_of_birth"
        case deletedAt = "deleted_at"
        case distance = "distance"
        case education = "education"
        case email = "email"
        case gender = "gender"
        case height = "height"
        case id = "id"
        case image = "image"
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
        case password = "password"
        case profession = "profession"
        case region = "region"
        case religion = "religion"
        case role = "role"
        case sexualOrientation = "sexual_orientation"
        case sort = "sort"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case userVerify = "user_verify"
    }
    
    init(from decoder: Decoder) throws {
        print("swipe : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("swipe : ",#line)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("swipe : ",#line)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        print("swipe : ",#line)
        childrenStatus = try values.decodeIfPresent(String.self, forKey: .childrenStatus)
        print("swipe : ",#line)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        print("swipe : ",#line)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        print("swipe : ",#line)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        print("swipe : ",#line)
        distance = try values.decodeIfPresent(Float.self, forKey: .distance)
        print("swipe : ",#line)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        print("swipe : ",#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("swipe : ",#line)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        print("swipe : ",#line)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        print("swipe : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("swipe : ",#line)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        print("swipe : ",#line)
        interestIn = try values.decodeIfPresent(String.self, forKey: .interestIn)
        print("swipe : ",#line)
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        print("swipe : ",#line)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        print("swipe : ",#line)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        print("swipe : ",#line)
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        print("swipe : ",#line)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        print("swipe : ",#line)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        print("swipe : ",#line)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        print("swipe : ",#line)
        lookingFor = try values.decodeIfPresent(String.self, forKey: .lookingFor)
        print("swipe : ",#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("swipe : ",#line)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("swipe : ",#line)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        print("swipe : ",#line)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        print("swipe : ",#line)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        print("swipe : ",#line)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        print("swipe : ",#line)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        print("swipe : ",#line)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        print("swipe : ",#line)
        sexualOrientation = try values.decodeIfPresent(String.self, forKey: .sexualOrientation)
        print("swipe : ",#line)
        sort = try values.decodeIfPresent(String.self, forKey: .sort)
        print("swipe : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("swipe : ",#line)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        print("swipe : ",#line)
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
        print("swipe : ",#line)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
    }
    
}

