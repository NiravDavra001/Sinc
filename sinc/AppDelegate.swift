//
//  AppDelegate.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import UIKit
import FBSDKLoginKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions)
        IQKeyboardManager.shared.enable = true
        
        if (getBoolUserDefaultValue(key: .isUserLogin)){
            NetworkManager.share.callGetCatagoryAPI { (result) in
                switch result {
                case .success(let resData):
                    print(resData)
                    
                    UserDefaultManager.share.storeModelToUserDefault(userData: resData.data, key: .storeUserPersonalInfo)
                case .failure( _):
                    break
                }
            }
        }
        
        
        return true
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    


}

