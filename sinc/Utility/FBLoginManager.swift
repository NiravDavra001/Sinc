//
//  FBLoginManager.swift
//  sinc
//
//  Created by mac on 05/03/21.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit


class FBLoginManager {
    
    func createFaceBookButton() -> FBLoginButton{
        let fbButton = FBLoginButton()
        fbButton.permissions = ["public_profile", "email"]
        return fbButton
    }
    
//    func checkAuthorizedToken() -> Bool{
//        if let token = AccessToken.current,
//           !token.isExpired {
//            // User is logged in, do work such as go to next view controller.
//        }
//    }
    
    
    
    
}
