//
//  SendOtpViewController.swift
//  sinc
//
//  Created by mac on 03/02/21.
//

import UIKit

class SendOtpViewController: UIViewController {

    @IBOutlet weak var btnAnotherWay : UIButton!
    @IBOutlet weak var btnSubmit : AppButtonView!
    @IBOutlet weak var lblConfirmMail : UILabel!
    @IBOutlet weak var txtOtp1: UITextField!
    @IBOutlet weak var txtOtp2: UITextField!
    @IBOutlet weak var txtOtp3: UITextField!
    @IBOutlet weak var txtOtp4: UITextField!
    
    @IBOutlet weak var lblResend: UILabel!
    var runCount = 60
    var timer: Timer?
    
    var finalOTP = 0
    
    let viewModel = SendOtpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtOtp1.delegate = self
        txtOtp2.delegate = self
        txtOtp3.delegate = self
        txtOtp4.delegate = self
        setUpUI()
    }
    
    func setUpUI(){
        txtOtp1.font = UIFont(name: FontName.SemiBold.rawValue, size: FontSize.Size_20.rawValue)
        txtOtp2.font = UIFont(name: FontName.SemiBold.rawValue, size: FontSize.Size_20.rawValue)
        txtOtp3.font = UIFont(name: FontName.SemiBold.rawValue, size: FontSize.Size_20.rawValue)
        txtOtp4.font = UIFont(name: FontName.SemiBold.rawValue, size: FontSize.Size_20.rawValue)
        
        btnAnotherWay.setButtonTitleGradiant(label : btnAnotherWay.titleLabel!,LeftColor: .appDarkGreen, RightColor: .appLightGreen)
        btnAnotherWay.setTitle(localizedString.loginOtherWay.getLocalizableString(), for: .normal)
        btnAnotherWay.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        
        lblResend.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        lblResend.text = localizedString.resendIn.getLocalizableString() + "(00:\(runCount))"
        
        lblConfirmMail.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        
        btnSubmit.setButton(name: "Submit",isGradiant: true)
        btnSubmit.Button.addTarget(self, action: #selector(onClickSubmitTouchUpInside), for: .touchUpInside)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countOtpTimer), userInfo: nil, repeats: true)
        
        let tapGestute = UITapGestureRecognizer(target: self, action: #selector(onTapResend))
        lblResend.addGestureRecognizer(tapGestute)
        
        self.view.manageKeyboard()
        
        let email = registerDetails.login_id ?? ""
        
        let attributedTxt = setAttributedText(text1: "Enter the confirmation code sent to ", text2: email, fontsize1: FontSize.Size_16.rawValue, fontsize2: FontSize.Size_16.rawValue, fontColor1: .black, fontColor2: .black, fontName1: FontName.Medium.rawValue, fontName2: FontName.Medium.rawValue)
        
        
        lblConfirmMail.attributedText = attributedTxt
    }

    @IBAction func loginOtherWayClickTouchUpinside(){
        self.popToRootViewController()
    }
    
    @objc func onClickSubmitTouchUpInside(){
        let otp = 1111//getIntegerUserDefaultValue(key: .OTP)
        if finalOTP == otp {
            setIntegerUserDefaultValue(value: 0, key: .OTP)
            showActivityIndicator(uiView: self.view)
            viewModel.callGetCatagoryAPI { (isFinished, error) in
                if isFinished {
                    self.pushViewController(controllerID: .TellAboutYouVC, storyBoardID: .Main)
                }
                else{
                    self.showAlert(message: error)
                }
                hideActivityIndicator(uiView: self.view)
            }
        }
        else{
            self.showAlert(message: localizedString.validOTP.getLocalizableString())
        }
    }
    @objc func previousViewController(){
        self.popViewController()
    }
    
    @objc func countOtpTimer (timer: Timer) {
        runCount -= 1
        if runCount == 0 {
            runCount = 0
            lblResend.text = "Resend"
            lblResend.isUserInteractionEnabled = true
            timer.invalidate()
            return
        }
        if runCount < 10 {
            lblResend.isUserInteractionEnabled = false
            lblResend.text = localizedString.resendIn.getLocalizableString() + "(00:0\(runCount))"
        }
        else{
            lblResend.isUserInteractionEnabled = false
            lblResend.text = localizedString.resendIn.getLocalizableString() + "(00:\(runCount))"
        }
    }
    
    @objc func onTapResend(_ sender : UITapGestureRecognizer){
        if self.timer?.isValid == false && !isActivityIndicaterIsOn {
            showActivityIndicator(uiView: self.view)
            viewModel.callResendOTP { (isFinished, error) in
                hideActivityIndicator(uiView: self.view)
                if isFinished {
                    self.runCount = 60
                    self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countOtpTimer), userInfo: nil, repeats: true)
                }
                else{
                    self.showAlert(message: error)
                }
            }
        }
    }
}

extension SendOtpViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField == txtOtp1 {
                txtOtp2.becomeFirstResponder()
            }
            else if textField == txtOtp2 {
                txtOtp3.becomeFirstResponder()
            }
            else if textField == txtOtp3 {
                txtOtp4.becomeFirstResponder()
            }
            else{
                let text = "\(txtOtp1.text ?? "0")\(txtOtp2.text  ?? "0")\(txtOtp3.text  ?? "")\(txtOtp4.text  ?? "")"
                finalOTP = Int(text) ?? 0
            }
            textField.resignFirstResponder()
        }
        else if textField.text?.count == 0 {
            textField.text = ""
            if textField == txtOtp4 {
                txtOtp3.becomeFirstResponder()
            }
            else if textField == txtOtp3 {
                txtOtp2.becomeFirstResponder()
            }
            else if textField == txtOtp2 {
                txtOtp1.becomeFirstResponder()
            }
        }
    }
}
