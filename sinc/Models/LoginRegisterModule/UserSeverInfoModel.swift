//
//  UserSeverInfoModel.swift
//  sinc
//
//  Created by mac on 05/03/21.
//

import Foundation

struct UserSeverInfoModel : Codable {
    let data : UserServerInfo?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UserServerInfo.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct UserServerInfo : Codable {
    
    let education : [Education]?
    let interest : [getInterest]?
    let interestIn : [InterestIn]?
    let isPets : [IsPet]?
    let lookingFor : [LookingFor]?
    let religion : [Religion]?
    let sexualOrientation : [SexualOrientation]?
    
    enum CodingKeys: String, CodingKey {
        case education = "education"
        case interest = "interest"
        case interestIn = "interest_in"
        case isPets = "is_pets"
        case lookingFor = "looking_for"
        case religion = "religion"
        case sexualOrientation = "sexual_orientation"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        education = try values.decodeIfPresent([Education].self, forKey: .education)
        interest = try values.decodeIfPresent([getInterest].self, forKey: .interest)
        interestIn = try values.decodeIfPresent([InterestIn].self, forKey: .interestIn)
        isPets = try values.decodeIfPresent([IsPet].self, forKey: .isPets)
        lookingFor = try values.decodeIfPresent([LookingFor].self, forKey: .lookingFor)
        religion = try values.decodeIfPresent([Religion].self, forKey: .religion)
        sexualOrientation = try values.decodeIfPresent([SexualOrientation].self, forKey: .sexualOrientation)
    }
    
}

struct SexualOrientation : Codable {
    
    let id : Int?
    let value : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
    
}

struct Religion : Codable {
    
    let id : Int?
    let value : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

struct LookingFor : Codable {
    let id : Int?
    let value : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

struct IsPet : Codable {
    let id : Int?
    let value : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

struct InterestIn : Codable {
    let id : Int?
    let value : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}

struct getInterest : Codable {
    let id : Int?
    let value : String?
    let colorID : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
        case colorID = "color"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
        colorID = try values.decodeIfPresent(String.self, forKey: .colorID)
    }
}

struct Education : Codable {
    let id : Int?
    let value : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case value = "value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }
}
