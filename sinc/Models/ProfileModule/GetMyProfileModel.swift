//
//  GetMyProfileModel.swift
//  sinc
//
//  Created by mac on 26/03/21.
//

import Foundation

struct GetMyProfileModel : Codable {
    
    let data : MyProfileDetails?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(MyProfileDetails.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct MyProfileDetails : Codable {
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
    let image : [Image]?
    let interest : [Interest]?
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
        case image = "image"
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
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("here 1")
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("here 2")
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        print("here 3")
        childrenStatus = try values.decodeIfPresent(String.self, forKey: .childrenStatus)
        print("here 4")
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("here 5")
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        print("here 6")
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        print("here 7")
        education = try values.decodeIfPresent(String.self, forKey: .education)
        print("here 8")
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("here 9")
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        print("here 10")
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        print("here 11")
        height = try values.decodeIfPresent(String.self, forKey: .height)
        print("here 12")
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("here 13")
        image = try values.decodeIfPresent([Image].self, forKey: .image)
        print("here 14")
        interest = try values.decodeIfPresent([Interest].self, forKey: .interest)
        print("here 15")
        interestIn = try values.decodeIfPresent(String.self, forKey: .interestIn)
        print("here 16")
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        print("here 17")
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        print("here 18")
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        print("here 19")
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        print("here 20")
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        print("here 21")
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        print("here 22")
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        print("here 23")
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        print("here 24")
        lookingFor = try values.decodeIfPresent(String.self, forKey: .lookingFor)
        print("here 25")
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("here 26")
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("here 27")
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        print("here 28")
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        print("here 29")
        region = try values.decodeIfPresent(String.self, forKey: .region)
        print("here 30")
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        print("here 31")
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        print("here 32")
        sexualOrientation = try values.decodeIfPresent(String.self, forKey: .sexualOrientation)
        print("here 33")
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("here 34")
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
        print("here 35")
    }
}
