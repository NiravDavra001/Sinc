//
//  DeleteAccountModel.swift
//  sinc
//
//  Created by mac on 25/03/21.
//
//{
//    "status": 1,
//    "message": "remove successfully",
//    "data": null
//}
import Foundation

struct DeleteAccountModel : Codable {
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}
