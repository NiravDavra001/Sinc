//
//  UserDefaultManager.swift
//  sinc
//
//  Created by mac on 25/02/21.
//

import Foundation


class UserDefaultManager {
    
    static let share = UserDefaultManager()
    
    let defaults = UserDefaults.standard
    
    func storeModelToUserDefault<T>(userData : T , key : UserDefaultModelKeys) where T: Codable{
        defaults.set(try? JSONEncoder().encode(userData) , forKey: key.rawValue)
    }
    
    
    
    func getModelDataFromUserDefults<T : Codable>(userData : T.Type ,key : UserDefaultModelKeys) -> T? {
        print(userData)
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("unable to decode this data")
        }
        return value
    }
    
//    func updateModelDataFromUserDefults<T : Codable>(userData : T.Type ,key : UserDefaultModelKeys , updateDict : [String:Any]){
//        let data = getModelDataFromUserDefults(userData: userData, key: key)
//        updateDict
//        defaults.set(data , forKey: key.rawValue)
//    }
    
    func getDataFromUserDefults(key : UserDefaultModelKeys) {
        
    }
    
    func clearAllUserDataAndModel(){
        removeUserdefultsKey(key: .isUserLogin)
        removeUserdefultsKey(key: .loginID)
        removeUserdefultsKey(key: .userName)
        removeUserdefultsKey(key: .appToken)
        removeUserdefultsKey(key: .region)
        removeUserdefultsKey(key: .userID)
        removeUserdefultsKey(key: .userReligion)
        removeUserdefultsKey(key: .userGender)
        removeUserdefultsKey(key: .userBio)
        removeUserdefultsKey(key: .userAlcohol)
        removeUserdefultsKey(key: .userSmoke)
        removeUserdefultsKey(key: .userPets)
        removeUserdefultsKey(key: .userDateOfBirth)
        removeUserdefultsKey(key: .userHeight)
        removeUserdefultsKey(key: .userPic)
        removeUserdefultsKey(key: .userLastLatitude)
        removeUserdefultsKey(key: .userLastLongitude)
        removeUserdefultsKey(key: .OTP)
        removeUserdefultsKey(key: .fbLoginID)
        removeUserdefultsKey(key: .fbName)
        removeUserdefultsKey(key: .fbEmail)
        removeUserdefultsKey(key: .isFbLogin)
        removeUserdefultsKey(key: .wantChild)
        removeUserdefultsKey(key: .isUserLogin)
        removeUserdefultsKey(key: .loginID)
        removeUserdefultsKey(key: .userName)
        removeUserdefultsKey(key: .appToken)
        removeUserdefultsKey(key: .region)
        
        removeUserDefualtsModels(key: .storeLoginModel)
        removeUserDefualtsModels(key: .storeRegisterModel)
        removeUserDefualtsModels(key: .storeUpdateProfileModel)
        removeUserDefualtsModels(key: .storeInterstModel)
        removeUserDefualtsModels(key: .storeUserPersonalInfo)
    }
    
    func removeUserdefultsKey(key : UserDefaultKeys){
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func removeUserDefualtsModels(key : UserDefaultModelKeys){
        defaults.removeObject(forKey: key.rawValue)
    }
    
}
