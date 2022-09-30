//
//  SettingViewController.swift
//  sinc
//
//  Created by mac on 08/03/21.
//

import UIKit

struct settingItems {
    let sectionItems : [String]?
    let isNotificationCounterHide : [Bool]
    let isDisCloserHide : [Bool]
}

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arraySettingItems = [settingItems]()
    let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "More"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
        tableView.register(UINib(nibName: "SelectNotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "SelectNotificationTableViewCell")
        tableView.register(UINib(nibName: "LocationSelectionSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "LocationSelectionSliderTableViewCell")
        
        
        self.tableView.register(UINib(nibName: "HeaderForSettingCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderForSettingCell")
        
        arraySettingItems.append(contentsOf: [settingItems(sectionItems: [localizedString.wantPremium.getLocalizableString()] , isNotificationCounterHide: [true],isDisCloserHide: [false])])
        
        arraySettingItems.append(contentsOf: [settingItems( sectionItems: [""] , isNotificationCounterHide: [true],isDisCloserHide: [false])])
        
        arraySettingItems.append(contentsOf: [settingItems(sectionItems: [""],isNotificationCounterHide: [true],isDisCloserHide: [false])])
        
        arraySettingItems.append(contentsOf: [settingItems( sectionItems: [localizedString.notification.getLocalizableString()],isNotificationCounterHide: [false],isDisCloserHide: [false])])

        arraySettingItems.append(contentsOf : [settingItems(sectionItems: [localizedString.feedback.getLocalizableString() ,localizedString.contactUs.getLocalizableString(),localizedString.rateUs.getLocalizableString(),localizedString.Share.getLocalizableString()] ,isNotificationCounterHide: [true,true,true,true],isDisCloserHide: [false,false,true,true])])
        
        arraySettingItems.append(contentsOf: [settingItems(sectionItems: [localizedString.deletedAccount.getLocalizableString(),localizedString.logOut.getLocalizableString()],isNotificationCounterHide: [true,true],isDisCloserHide: [true,true])])
        
    }
    
    func createAlert(message : String , btnText1 : String ,btnText2 : String){
        
        let alert = UIAlertController(title: "Sink", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnText1, style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: btnText2, style: .destructive, handler: { (_) in
            if btnText2 == "Logout"{
                UserDefaultManager.share.clearAllUserDataAndModel()
                let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Main.rawValue, bundle: nil)
                let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.LoginVC.rawValue)
                let navContller = UINavigationController(rootViewController: homeViewController)
                sceneDelegate?.window?.rootViewController = navContller
                sceneDelegate?.window?.makeKeyAndVisible()
            }
            else if btnText2 == "Delete"{
                showActivityIndicator(uiView: self.view)
                self.viewModel.callDeleteAccountAPI { (isFinsished, message) in
                    hideActivityIndicator(uiView: self.view)
                    if isFinsished {
                        UserDefaultManager.share.clearAllUserDataAndModel()
                        let storyBoard = UIStoryboard(name: StoryBoardIdentifiers.Main.rawValue, bundle: nil)
                        let homeViewController = storyBoard.instantiateViewController(identifier: ViewControllerIdentifiers.LoginVC.rawValue)
                        let navContller = UINavigationController(rootViewController: homeViewController)
                        sceneDelegate?.window?.rootViewController = navContller
                        sceneDelegate?.window?.makeKeyAndVisible()
                    }
                }
            }
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension SettingViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arraySettingItems.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySettingItems[section].sectionItems?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectNotificationTableViewCell") as? SelectNotificationTableViewCell
            return cell ?? UITableViewCell()
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSelectionSliderTableViewCell") as? LocationSelectionSliderTableViewCell
            return cell ?? UITableViewCell()
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as? SettingsTableViewCell
            cell?.lblTitle.text = arraySettingItems[indexPath.section].sectionItems?[indexPath.row]
            cell?.lblNotificationCount.isHidden = true
//                arraySettingItems[indexPath.section].isNotificationCounterHide[indexPath.row]
            cell?.btnDisclouser.isHidden = arraySettingItems[indexPath.section].isDisCloserHide[indexPath.row]
            if indexPath.section == 0 {
                cell?.manageFontSizeAndColor()
            }
            else{
                cell?.setUpUI()
            }
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 34 * UIScreen.main.bounds.height / 812
        }
        else if section == 1{
//            return 51 * UIScreen.main.bounds.height / 812
            return UITableView.automaticDimension
        }
        else if section == 2{
            return 56 * UIScreen.main.bounds.height / 812
        }
        else {
            return 24 * UIScreen.main.bounds.height / 812
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 2 || section == 1{
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderForSettingCell") as? HeaderForSettingCell
            if section == 1 {
                header?.lblTitle.text = localizedString.location.getLocalizableString()
                header?.btnSwitch.isHidden = true
            }
            if section == 2 {
                header?.lblTitle.text = localizedString.enableNotification.getLocalizableString()
            }
            
            
            return header ?? UITableViewHeaderFooterView()
        }
        
        else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            self.presentViewController(controllerID: .PremiumFeaturesVC, storyBoardID: .Setting)
        case IndexPath(row: 0, section: 3):
            print("go to notification view Controller From Here")
        case IndexPath(row: 0, section: 4):
            self.pushViewController(controllerID: .feedbackVC, storyBoardID: .Setting)
        case IndexPath(row: 1, section: 4):
            self.pushViewController(controllerID: .contactUsVC, storyBoardID: .Setting)
        case IndexPath(row: 2, section: 4):
            print("go to rate us view Controller From Here")
            self.createAlert(message: "Development In Progress", btnText1: "Cancel", btnText2: "Okay")
        case IndexPath(row: 3, section: 4):
            let text = "This is some text that I want to share."
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            self.present(activityViewController, animated: true, completion: nil)
            
        case IndexPath(row: 0, section: 5):
            self.createAlert(message: localizedString.sureDelete.getLocalizableString(), btnText1: "Cancel", btnText2: "Delete")
        case IndexPath(row: 1, section: 5):
            self.createAlert(message: localizedString.sureLogout.getLocalizableString(), btnText1: "Cancel", btnText2: "Logout")
        default:
            break
        }
    }
}


