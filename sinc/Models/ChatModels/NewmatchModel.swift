//
//  NewmatchModel.swift
//  sinc
//
//  Created by mac on 12/05/21.
//

import Foundation

//
//  ChatListModel.swift
//  sinc
//
//  Created by mac on 06/05/21.
//

import Foundation

struct NewmatchModel : Codable {
    
    let data : [NewMatchData]?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([NewMatchData].self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct NewMatchData : Codable {
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
        case profession = "profession"
        case region = "region"
        case religion = "religion"
        case role = "role"
        case sexualOrientation = "sexual_orientation"
        case updatedAt = "updated_at"
        case userVerify = "user_verify"
    }
    
    init(from decoder: Decoder) throws {
        print("match model : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("match model : ",#line)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("match model : ",#line)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        print("match model : ",#line)
        childrenStatus = try values.decodeIfPresent(String.self, forKey: .childrenStatus)
        print("match model : ",#line)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        print("match model : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("match model : ",#line)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        print("match model : ",#line)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        print("match model : ",#line)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        print("match model : ",#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("match model : ",#line)
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        print("match model : ",#line)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        print("match model : ",#line)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        print("match model : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("match model : ",#line)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        print("match model : ",#line)
        interestIn = try values.decodeIfPresent(String.self, forKey: .interestIn)
        print("match model : ",#line)
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        print("match model : ",#line)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        print("match model : ",#line)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        print("match model : ",#line)
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        print("match model : ",#line)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        print("match model : ",#line)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        print("match model : ",#line)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        print("match model : ",#line)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        print("match model : ",#line)
        lookingFor = try values.decodeIfPresent(String.self, forKey: .lookingFor)
        print("match model : ",#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("match model : ",#line)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("match model : ",#line)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        print("match model : ",#line)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        print("match model : ",#line)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        print("match model : ",#line)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        print("match model : ",#line)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        print("match model : ",#line)
        sexualOrientation = try values.decodeIfPresent(String.self, forKey: .sexualOrientation)
        print("match model : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("match model : ",#line)
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
    }
}
