//
//  LoginViewController.swift
//  sinc
//
//  Created by mac on 02/02/21.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginWithMailView : AppButtonView!
    @IBOutlet weak var loginWithPhoneView : AppButtonView!
    @IBOutlet weak var loginWithFBView : AppButtonView!
    @IBOutlet weak var welcomeTitle : UILabel!
    @IBOutlet weak var lblSignUp : UILabel!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        if let token = AccessToken.current,
           !token.isExpired {
            
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    func setUpUI(){
        welcomeTitle.attributedText = setAttributedText(text1: "Welcome", text2: "\nto Networking App", fontsize1: FontSize.Size_32.rawValue, fontsize2: FontSize.Size_16.rawValue, fontColor1: .black, fontColor2: .black,fontName1 : FontName.Medium.rawValue, fontName2 : FontName.Regular.rawValue)

        let btnTitle = setAttributedText(text1: "Don't have an account? ", text2: "SignUp", fontsize1: FontSize.Size_14.rawValue, fontsize2: FontSize.Size_14.rawValue, fontColor1: .black, fontColor2: .appLightGreen, fontName1: FontName.Regular.rawValue, fontName2: FontName.SemiBold.rawValue)
        lblSignUp.attributedText = btnTitle
        
        loginWithFBView.setButton(name: "Login with facebook",imageName: "Facebook",isGradiant: true)
        loginWithMailView.setButton(name: "Login with email",imageName: "Email",isGradiant: true)
        loginWithPhoneView.setButton(name: "Login with phone",imageName: "Phone",isGradiant: true)
        loginWithFBView.Button.addTarget(self, action: #selector(onClickFbBtn), for: .touchUpInside)
        
        let loginBtn = FBLoginButton()
        loginWithFBView.Button.addSubview(loginBtn)
        loginBtn.frame.origin = loginWithFBView.Button.frame.origin
        loginBtn.frame.size = loginWithFBView.Button.frame.size
        loginBtn.permissions = ["public_profile", "email"]
        loginBtn.delegate = self
        
        loginBtn.setBackgroundImage(nil, for: .selected)
        loginBtn.setBackgroundImage(nil, for: .normal)
        loginBtn.setBackgroundImage(nil, for: .highlighted)
        
        loginBtn.setBackgroundImage(nil, for: .focused)
        loginBtn.setBackgroundImage(nil, for: .application)
        loginBtn.setBackgroundImage(nil, for: .disabled)
        loginBtn.setBackgroundImage(nil, for: .reserved)
        
        loginBtn.imageView?.tintColor = .clear
        
        loginWithPhoneView.Button.addTarget(self, action: #selector(onClickPhoneBtn), for: .touchUpInside)
        loginWithMailView.Button.addTarget(self, action: #selector(onClickEmailBtn), for: .touchUpInside)
        
        lblSignUp.isUserInteractionEnabled = true
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.onClickSignUpTouchupInside(_:)))
        lblSignUp.addGestureRecognizer(labelTap)
    }
    
    @objc func onClickFbBtn(){
//        self.showAlert(message: "Development In Progress")
    }
    @objc func onClickEmailBtn(){
        let vc = loadViewController(Storyboard: .Main, ViewController: .NewLoginVC) as! NewLoginViewController
        vc.mode = loginMode.email
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickPhoneBtn(){
        let vc = loadViewController(Storyboard: .Main, ViewController: .NewLoginVC) as! NewLoginViewController
        vc.mode = loginMode.phone
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickSignUpTouchupInside(_ sender: UITapGestureRecognizer){
        let termsRange = (lblSignUp.text! as NSString).range(of: "SignUp")
        if sender.didTapAttributedTextInLabel(label: lblSignUp, inRange: termsRange) {
            self.pushViewController(controllerID: .QuestionVC, storyBoardID: .Main)
        }
    }
    
    
    
}
extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}

extension LoginViewController : LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        print(result ?? "")
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, relationship_status,email,phone"], httpMethod: .get).start { (connection, result, error) in
            if (error == nil){
                let fbDetails = result as! NSDictionary
                guard let id = fbDetails["id"] as? String ,id != "" else {
                    let loginManager = LoginManager()
                    loginManager.logOut()
                    return
                }
                guard let name = fbDetails["first_name"] as? String ,name != "" else {
                    let loginManager = LoginManager()
                    loginManager.logOut()
                    return
                }
                guard let email = fbDetails["email"] as? String ,email != "" else {
                    let loginManager = LoginManager()
                    loginManager.logOut()
                    return
                }
                
                setStringUserDefaultValue(value: id, key: .fbLoginID)
                setStringUserDefaultValue(value: name, key: .fbName)
                setStringUserDefaultValue(value: email, key: .fbEmail)
                setBoolUserDefaultValue(value: true, key: .isFbLogin)
                print(fbDetails)
                self.pushViewController(controllerID: .QuestionVC, storyBoardID: .Main)
                
            }
        }
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("user logged Out")
    }
    
    
}
