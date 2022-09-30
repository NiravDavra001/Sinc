//
//  FilterProfilesModel.swift
//  sinc
//
//  Created by mac on 16/04/21.
//

import Foundation

struct FilterProfilesModel : Codable {
    
    let data : [FilterDataModel]?
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
        data = try values.decodeIfPresent([FilterDataModel].self, forKey: .data)
        print("line no : ",#line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("line no : ",#line)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        print("line no : ",#line)
    }
}
struct FilterDataModel : Codable {
    
    let age : String?
    let bio : String?
    let childrenStatus : String?
    let createdAt : String?
    let dateOfBirth : String?
    let deletedAt : String?
    let education : String?
    let email : String?
    let emailVerifiedAt : String?
    let gender : Int?
    let height : String?
    let id : Int?
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
        case createdAt = "created_at"
        case dateOfBirth = "date_of_birth"
        case deletedAt = "deleted_at"
        case education = "education"
        case email = "email"
        case emailVerifiedAt = "email_verified_at"
        case gender = "gender"
        case height = "height"
        case id = "id"
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
        print("line no : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("line no : ",#line)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("line no : ",#line)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        print("line no : ",#line)
        childrenStatus = try values.decodeIfPresent(String.self, forKey: .childrenStatus)
        print("line no : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("line no : ",#line)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        print("line no : ",#line)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        print("line no : ",#line)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        print("line no : ",#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("line no : ",#line)
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        print("line no : ",#line)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        print("line no : ",#line)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        print("line no : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("line no : ",#line)
        interestIn = try values.decodeIfPresent(String.self, forKey: .interestIn)
        print("line no : ",#line)
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        print("line no : ",#line)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        print("line no : ",#line)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        print("line no : ",#line)
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        print("line no : ",#line)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        print("line no : ",#line)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        print("line no : ",#line)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        print("line no : ",#line)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        print("line no : ",#line)
        lookingFor = try values.decodeIfPresent(String.self, forKey: .lookingFor)
        print("line no : ",#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("line no : ",#line)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("line no : ",#line)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        print("line no : ",#line)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        print("line no : ",#line)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        print("line no : ",#line)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        print("line no : ",#line)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        print("line no : ",#line)
        sexualOrientation = try values.decodeIfPresent(String.self, forKey: .sexualOrientation)
        print("line no : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("line no : ",#line)
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
        print("line no : ",#line)
    }
    
}
