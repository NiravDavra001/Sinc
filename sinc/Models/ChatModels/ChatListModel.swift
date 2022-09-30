//
//  ChatListModel.swift
//  sinc
//
//  Created by mac on 06/05/21.
//

import Foundation

struct ChatListModel : Codable {
    let data : ChatListData?
    let message : String?
    let status : Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case message = "message"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        print("chat list module : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("chat list module : ",#line)
        data = try values.decodeIfPresent(ChatListData.self, forKey: .data)
        print("chat list module : ",#line)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        print("chat list module : ",#line)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}

struct ChatListData : Codable {
    let currentPage : Int?
    let currentUser : CurrentUser?
    let data : [ChatLastMessageDetails]?
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
        print("chat list module : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("chat list module : ",#line)
        currentPage = try values.decodeIfPresent(Int.self, forKey: .currentPage)
        print("chat list module : ",#line)
        currentUser = try values.decodeIfPresent(CurrentUser.self, forKey: .currentUser)
        print("chat list module : ",#line)
        data = try values.decodeIfPresent([ChatLastMessageDetails].self, forKey: .data)
        print("chat list module : ",#line)
        firstPageUrl = try values.decodeIfPresent(String.self, forKey: .firstPageUrl)
        print("chat list module : ",#line)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        print("chat list module : ",#line)
        lastPage = try values.decodeIfPresent(Int.self, forKey: .lastPage)
        print("chat list module : ",#line)
        lastPageUrl = try values.decodeIfPresent(String.self, forKey: .lastPageUrl)
        print("chat list module : ",#line)
        links = try values.decodeIfPresent([Link].self, forKey: .links)
        print("chat list module : ",#line)
        nextPageUrl = try values.decodeIfPresent(String.self, forKey: .nextPageUrl)
        print("chat list module : ",#line)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        print("chat list module : ",#line)
        perPage = try values.decodeIfPresent(Int.self, forKey: .perPage)
        print("chat list module : ",#line)
        prevPageUrl = try values.decodeIfPresent(String.self, forKey: .prevPageUrl)
        print("chat list module : ",#line)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        print("chat list module : ",#line)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }
}
struct Link : Codable {
    
    let active : Bool?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case active = "active"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        print("chat list : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("chat list : ",#line)
        active = try values.decodeIfPresent(Bool.self, forKey: .active)
        print("chat list : ",#line)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}

struct ReceiverUser : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}

struct ChatLastMessageDetails : Codable {
    
    let conversation : Conversation?
    let conversationId : Int?
    let createdAt : String?
    let id : Int?
    let isRead : Int?
    let message : String?
    let messageType : Int?
    let opositeId : Int?
    let receiverUser : ReceiverUser?
    let senderId : Int?
    let senderUser : SenderUser?
    let updatedAt : String?
    let visible : String?
    
    enum CodingKeys: String, CodingKey {
        case conversation = "conversation"
        case conversationId = "conversation_id"
        case createdAt = "created_at"
        case id = "id"
        case isRead = "is_read"
        case message = "message"
        case messageType = "message_type"
        case opositeId = "opositeId"
        case receiverUser = "receiver_user"
        case senderId = "sender_id"
        case senderUser = "sender_user"
        case updatedAt = "updated_at"
        case visible = "visible"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        conversation = try values.decodeIfPresent(Conversation.self, forKey: .conversation)
        conversationId = try values.decodeIfPresent(Int.self, forKey: .conversationId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isRead = try values.decodeIfPresent(Int.self, forKey: .isRead)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        messageType = try values.decodeIfPresent(Int.self, forKey: .messageType)
        opositeId = try values.decodeIfPresent(Int.self, forKey: .opositeId)
        receiverUser = try values.decodeIfPresent(ReceiverUser.self, forKey: .receiverUser)
        senderId = try values.decodeIfPresent(Int.self, forKey: .senderId)
        senderUser =  try values.decodeIfPresent(SenderUser.self, forKey: .senderUser)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        visible = try values.decodeIfPresent(String.self, forKey: .visible)
    }
}

struct SenderUser : Codable {
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
    var image : String?
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
        print("chat list : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("chat list : ",#line)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        print("chat list : ",#line)
        bio = try values.decodeIfPresent(String.self, forKey: .bio)
        print("chat list : ",#line)
        childrenStatus = try values.decodeIfPresent(String.self, forKey: .childrenStatus)
        print("chat list : ",#line)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        print("chat list : ",#line)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        print("chat list : ",#line)
        dateOfBirth = try values.decodeIfPresent(String.self, forKey: .dateOfBirth)
        print("chat list : ",#line)
        deletedAt = try values.decodeIfPresent(String.self, forKey: .deletedAt)
        print("chat list : ",#line)
        education = try values.decodeIfPresent(String.self, forKey: .education)
        print("chat list : ",#line)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        print("chat list : ",#line)
        emailVerifiedAt = try values.decodeIfPresent(String.self, forKey: .emailVerifiedAt)
        print("chat list : ",#line)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender)
        print("chat list : ",#line)
        height = try values.decodeIfPresent(String.self, forKey: .height)
        print("chat list : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("chat list : ",#line)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        print("chat list : ",#line)
        interestIn = try values.decodeIfPresent(String.self, forKey: .interestIn)
        print("chat list : ",#line)
        isAlcohol = try values.decodeIfPresent(Int.self, forKey: .isAlcohol)
        print("chat list : ",#line)
        isNew = try values.decodeIfPresent(Int.self, forKey: .isNew)
        print("chat list : ",#line)
        isPets = try values.decodeIfPresent(String.self, forKey: .isPets)
        print("chat list : ",#line)
        isSmoke = try values.decodeIfPresent(Int.self, forKey: .isSmoke)
        print("chat list : ",#line)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        print("chat list : ",#line)
        loginId = try values.decodeIfPresent(String.self, forKey: .loginId)
        print("chat list : ",#line)
        loginType = try values.decodeIfPresent(Int.self, forKey: .loginType)
        print("chat list : ",#line)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        print("chat list : ",#line)
        lookingFor = try values.decodeIfPresent(String.self, forKey: .lookingFor)
        print("chat list : ",#line)
        mobile = try values.decodeIfPresent(String.self, forKey: .mobile)
        print("chat list : ",#line)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        print("chat list : ",#line)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        print("chat list : ",#line)
        profession = try values.decodeIfPresent(String.self, forKey: .profession)
        print("chat list : ",#line)
        region = try values.decodeIfPresent(String.self, forKey: .region)
        print("chat list : ",#line)
        religion = try values.decodeIfPresent(String.self, forKey: .religion)
        print("chat list : ",#line)
        role = try values.decodeIfPresent(Int.self, forKey: .role)
        print("chat list : ",#line)
        sexualOrientation = try values.decodeIfPresent(String.self, forKey: .sexualOrientation)
        print("chat list : ",#line)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        print("chat list : ",#line)
        userVerify = try values.decodeIfPresent(Int.self, forKey: .userVerify)
    }
    
}
struct CurrentUser : Codable {
    
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        print("chat list module : ",#line)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        print("chat list module : ",#line)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        print("chat list module : ",#line)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}

struct Conversation : Codable {
    
    let createdAt : String?
    let id : Int?
    let isReceiverBlock : Int?
    let isSenderBlock : Int?
    let receiverId : Int?
    let senderId : Int?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case id = "id"
        case isReceiverBlock = "is_receiver_block"
        case isSenderBlock = "is_sender_block"
        case receiverId = "receiver_id"
        case senderId = "sender_id"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isReceiverBlock = try values.decodeIfPresent(Int.self, forKey: .isReceiverBlock)
        isSenderBlock = try values.decodeIfPresent(Int.self, forKey: .isSenderBlock)
        receiverId = try values.decodeIfPresent(Int.self, forKey: .receiverId)
        senderId = try values.decodeIfPresent(Int.self, forKey: .senderId)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}
