//
//  NewLoginViewController.swift
//  sinc
//
//  Created by mac on 03/02/21.
//

import UIKit
import SkyFloatingLabelTextField

class NewLoginViewController: UIViewController {
    
    
    @IBOutlet weak var txtEmail : SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword : SkyFloatingLabelTextField!
    @IBOutlet weak var btnLogin : AppButtonView!
    
    @IBOutlet weak var btnHidePassword: UIButton!
    var mode : loginMode = .email
    var viewModel = LoginViewModel()
    var catagoryViewModel = SendOtpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.view.manageKeyboard()
    }
    
    
    func setUpUI(){
        if mode == loginMode.phone{
            txtEmail.placeholder = loginMode.phone.rawValue
            txtEmail.keyboardType = .numberPad
        }
        else{
            txtEmail.placeholder = loginMode.email.rawValue
            txtEmail.keyboardType = .emailAddress
        }
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.topItem?.title = "Login"
        self.navigationController?.navigationBar.tintColor = .black
        
        btnLogin.setButton(name: "Login",isGradiant: true)
        btnLogin.Button.addTarget(self, action: #selector(changeViewController), for: .touchUpInside)
    }
    @IBAction func onTapHidePassword(_ sender: Any) {
        manageHideUnhidePassword(pass: btnHidePassword)
    }
    func manageHideUnhidePassword(pass : UIButton){
        if pass.isSelected {
            btnHidePassword.isSelected = false
            txtPassword.isSecureTextEntry = true
        }
        else{
            btnHidePassword.isSelected = true
            txtPassword.isSecureTextEntry = false
        }
        pass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        pass.setImage(UIImage(systemName: "eye"), for: .selected)
        
    }
    @objc func changeViewController(){
        
        let login_id = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if mode == loginMode.phone {
            if login_id == "" || login_id == nil {
                self.showAlert(message: localizedString.enterPhone.getLocalizableString())
                return
            }
        }
        else{
            if login_id == "" || login_id == nil {
                self.showAlert(message: localizedString.enterEmail.getLocalizableString())
                return
            }
            else if login_id?.isValidEmail() == false {
                self.showAlert(message: localizedString.validEmail.getLocalizableString())
                return
            }
        }
        if password == "" || password == nil {
            self.showAlert(message: localizedString.enterPassword.getLocalizableString())
            return
        }
        
        showActivityIndicator(uiView: self.view)
        let params = ["login_id":login_id ?? "" , "password" : password ?? ""] as [String : Any]
        viewModel.callLoginAPI(params: params) { (response ,isFinished,error)  in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.callGetCatagoryAPI(response: response)
            }
            else {
                self.showAlert(message: error)
                hideActivityIndicator(uiView: self.view)
            }
        }
    }
    
    func callGetCatagoryAPI(response : LoginModel?){
        catagoryViewModel.callGetCatagoryAPI { (isFinished, error) in
            if isFinished {
                if (response?.data?.user?.dateOfBirth == "" || response?.data?.user?.dateOfBirth == nil || response?.data?.user?.bio == "" || response?.data?.user?.gender == nil || response?.data?.user?.bio == nil)  {
                    self.pushViewController(controllerID: .TellAboutYouVC, storyBoardID: .Main)
                }
                else if response?.data?.user?.image?.isEmpty == true {
                    self.pushViewController(controllerID: .UpdatePhotosVC, storyBoardID: .Main)
                }
                else if response?.data?.user?.interest?.isEmpty == true {
                    self.pushViewController(controllerID: .InterestsVC, storyBoardID: .Main)
                }
                else{
                    setBoolUserDefaultValue(value: true, key: .isUserLogin)
                    sceneDelegate?.setUpRootViewController()
                }
            }
            else{
                self.showAlert(message: error)
            }
            hideActivityIndicator(uiView: self.view)
        }
    }
}

extension NewLoginViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtEmail == textField {
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
        else{
            txtPassword.resignFirstResponder()
        }
    }
}
