//
//  RegisterDetails.swift
//  sinc
//
//  Created by mac on 16/02/21.
//

import Foundation
import UIKit


struct RegisterDetails : Codable {
//    MARK:- Here login_id -> represent's Email / Phone
    var userID : String?
    var bio : String?
    var createdAt : String?
    var dateOfBirth : Int?
    var gender : Int?
    var id : Int?
    var isAlcohol : Int?
    var isPets : String?
    var isSmoke : Int?
    var login_type : Int?
    var login_id : String?
    var name : String?
    var religion : Int?
    var role : Int?
    var region : String?
    var password : String?
    var height : String?
    var interest : String?
    var looking_for : String?
    var interest_in : String?
    var sexual_orientation : String?
    var education : String?
    var profession : String?
    var childrenStatus : String?
    var minHeight : String?
    var maxHeight : String?
    var minAge : String?
    var maxAge : String?
    var image1 : Data?
    var image2 : Data?
    var image3 : Data?
    var image4 : Data?
    var image5 : Data?
    var image6 : Data?
}
