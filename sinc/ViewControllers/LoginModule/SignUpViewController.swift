//
//  SignUpViewController.swift
//  sinc
//
//  Created by mac on 04/02/21.
//

import UIKit
import SkyFloatingLabelTextField
import MapKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var txtSignUp : UILabel!
    @IBOutlet weak var bottomView : BottomNavPannel!
    
    @IBOutlet weak var txtEmailOrPhone: SkyFloatingLabelTextField!
    @IBOutlet weak var txtName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPassword: SkyFloatingLabelTextField!
    @IBOutlet weak var txtConfirmPassword: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnHidePassword: UIButton!
    @IBOutlet weak var btnHideConfirmPassword: UIButton!
    
    var viewModel = RegisterViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.view.manageKeyboard()
    }
    
    
    func setUpUI(){
        
        txtEmailOrPhone.delegate = self
        txtName.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        txtName.becomeFirstResponder()
        
        txtSignUp.font = UIFont(name: FontName.Bold.rawValue, size: FontSize.Size_20.rawValue)
        bottomView.btnNext.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
        bottomView.txtNext.addTarget(self, action: #selector(nextViewController), for: .touchUpInside)
        bottomView.btnBack.addTarget(self, action: #selector(previousViewController), for: .touchUpInside)
    }
    
    
    
    
    
    @objc func nextViewController(){
        
        let name        = txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let login_id    = txtEmailOrPhone.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password    = txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let region      = getRegionCode()
        let confirmPassword = txtConfirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if name == "" || name == nil {
            self.showAlert(message: localizedString.enterName.getLocalizableString())
            return
        }
        else if login_id == "" || login_id == nil {
            self.showAlert(message: localizedString.enterEmailPhone.getLocalizableString())
            return
        }
        else if password?.validatePassword() == false {
            self.showAlert(message: localizedString.validPassword.getLocalizableString())
            return
        }
        else if password != confirmPassword {
            self.showAlert(message: localizedString.matchPassword.getLocalizableString())
            return
        }
        
        registerDetails.name          = name
        registerDetails.login_id      = login_id
        registerDetails.login_type    = 0
        registerDetails.region        = region
        registerDetails.password      = password
        registerDetails.childrenStatus = "\(getIntegerUserDefaultValue(key: .wantChild))"
        
        showActivityIndicator(uiView: self.view)
        
        viewModel.callRegisterAPI { (isFinished,error) in
            if isFinished {
                hideActivityIndicator(uiView: self.view)
                self.pushViewController(controllerID: .SendOtpVC, storyBoardID: .Main)
            }
            else{
                hideActivityIndicator(uiView: self.view)
                self.showAlert(message: error)
            }
        }
    }
    @objc func previousViewController(){
        
        self.popViewController()
    }
    
    func manageHideUnhidePassword(pass : UIButton , confirmPass : UIButton){
        if pass.isSelected || confirmPass.isSelected {
            btnHidePassword.isSelected = false
            btnHideConfirmPassword.isSelected = false
            txtPassword.isSecureTextEntry = true
            txtConfirmPassword.isSecureTextEntry = true
        }
        else{
            btnHidePassword.isSelected = true
            btnHideConfirmPassword.isSelected = true
            txtPassword.isSecureTextEntry = false
            txtConfirmPassword.isSecureTextEntry = false
        }
        pass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        pass.setImage(UIImage(systemName: "eye"), for: .selected)
        confirmPass.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        confirmPass.setImage(UIImage(systemName: "eye"), for: .selected)
    }
    
    @IBAction func onClickPasswordHide(_ sender: UIButton) {
        manageHideUnhidePassword(pass: sender, confirmPass: btnHideConfirmPassword)
    }
    
    @IBAction func onClickConfirmPasswordHide(_ sender: UIButton) {
        manageHideUnhidePassword(pass: btnHidePassword, confirmPass: sender)
    }
}
extension SignUpViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txtName {
            txtEmailOrPhone.becomeFirstResponder()
        }
        else if textField == txtEmailOrPhone {
            txtPassword.becomeFirstResponder()
        }
        else if textField == txtPassword {
            txtConfirmPassword.becomeFirstResponder()
        }
        return true
    }
}

