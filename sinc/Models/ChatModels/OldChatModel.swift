//
//  OldChatModel.swift
//  sinc
//
//  Created by mac on 27/05/21.
//

import Foundation

struct OldChatModel : Codable {
    let data : OldChatData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        print("old chat : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("old chat : ",#line)
        data = try values.decodeIfPresent(OldChatData.self, forKey: .data)
        print("old chat : ",#line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("old chat : ",#line)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct OldChatData : Codable {
    let currentPage : Int?
    let currentUser : CurrentUser?
    let data : [OldChatDetails]?
    let firstPageUrl : String?
    let from : Int?
    let lastPage : Int?
    let lastPageUrl : String?
    let links : [Link]?
    let nextPageUrl : String?
    let path : String?
    let perPage : Int?
    let prevPageUrl : String?
    let to : Int?
    let total : Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case currentUser = "current_user"
        case data = "data"
        case firstPageUrl = "first_page_url"
        case from = "from"
        case lastPage = "last_page"
        case lastPageUrl = "last_page_url"
        case links = "links"
        case nextPageUrl = "next_page_url"
        case path = "path"
        case perPage = "per_page"
        case prevPageUrl = "prev_page_url"
        case to = "to"
        case total = "total"
    }
    init(from decoder: Decoder) throws {
        print("old chat : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("old chat : ",#line)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        print("old chat : ",#line)
        currentUser =  try values.decodeIfPresent(CurrentUser.self, forKey: .currentUser)
        print("old chat : ",#line)
        data = try values.decodeIfPresent([OldChatDetails].self, forKey: .data)
        print("old chat : ",#line)
        firstPageUrl = try values.decodeIfPresent(String.self, forKey: .firstPageUrl)
        print("old chat : ",#line)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        print("old chat : ",#line)
        lastPage = try values.decodeIfPresent(Int.self, forKey: .lastPage)
        print("old chat : ",#line)
        lastPageUrl = try values.decodeIfPresent(String.self, forKey: .lastPageUrl)
        print("old chat : ",#line)
        links = try values.decodeIfPresent([Link].self, forKey: .links)
        print("old chat : ",#line)
        nextPageUrl = try values.decodeIfPresent(String.self, forKey: .nextPageUrl)
        print("old chat : ",#line)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        print("old chat : ",#line)
        perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
        print("old chat : ",#line)
        prevPageUrl = try values.decodeIfPresent(String.self, forKey: .prevPageUrl)
        print("old chat : ",#line)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        print("old chat : ",#line)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
}

struct OldChatDetails : Codable {
    let conversationId : Int?
    let createdAt : String?
    let id : Int?
    let isRead : Int?
    let message : String?
    let messageType : Int?
    let senderId : Int?
    let senderUser : SenderUser?
    let updatedAt : String?
    let visible : String?
    
    enum CodingKeys: String, CodingKey {
        case conversationId = "conversation_id"
        case createdAt = "created_at"
        case id = "id"
        case isRead = "is_read"
        case message = "message"
        case messageType = "message_type"
        case senderId = "sender_id"
        case senderUser = "sender_user"
        case updatedAt = "updated_at"
        case visible = "visible"
    }
    
    init(from decoder: Decoder) throws {
        print("old chat : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("old chat : ",#line)
        conversationId = try values.decodeIfPresent(Int.self, forKey: .conversationId)
        print("old chat : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("old chat : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("old chat : ",#line)
        isRead = try values.decodeIfPresent(Int.self, forKey: .isRead)
        print("old chat : ",#line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("old chat : ",#line)
        messageType = try values.decodeIfPresent(Int.self, forKey: .messageType)
        print("old chat : ",#line)
        senderId = try values.decodeIfPresent(Int.self, forKey: .senderId)
        print("old chat : ",#line)
        senderUser = try values.decodeIfPresent(SenderUser.self, forKey: .senderUser)
        print("old chat : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("old chat : ",#line)
        visible = try values.decodeIfPresent(String.self, forKey: .visible)
    }
}
