//
//  QuestionViewController.swift
//  sinc
//
//  Created by mac on 03/02/21.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var lblSignUp : UILabel!
    @IBOutlet weak var lblQuestion : UILabel!
    @IBOutlet weak var btnYes : UIButton!
    @IBOutlet weak var btnNo : UIButton!
//    @IBOutlet weak var btnNext : UIButton!
//    @IBOutlet weak var lblNext : UILabel!
    @IBOutlet weak var bottomPanelView: UIView!
    @IBOutlet weak var bottomView : BottomNavPannel!
    @IBOutlet weak var nextView : UIView!
    
    @IBOutlet weak var btnNotSure: UIButton!
    var isNextTapped = false
    
    let viewModel = QuestionsViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnYes.setUpCornerRadius(btnYes.bounds.height / 2)
        btnNo.setUpCornerRadius(btnNo.bounds.height / 2)
        btnNotSure.setUpCornerRadius(btnNotSure.bounds.height / 2)
    }
    
    func setUpUI(){
        
        lblSignUp.font = UIFont(name: FontName.Bold.rawValue, size: FontSize.Size_20.rawValue)
        lblQuestion.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_20.rawValue)
        lblQuestion.text = localizedString.haveChild.getLocalizableString()
        
        btnYes.titleLabel?.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        btnNo.titleLabel?.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        btnNotSure.titleLabel?.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        
        btnYes.setBorder(1.0)
        btnNo.setBorder(1.0)
        btnNotSure.setBorder(1.0)
        
        
        btnNo.isSelected = false
        btnNotSure.isHidden = true
        
        bottomView.btnNext.addTarget(self, action: #selector(onClickNextVC), for: .touchUpInside)
        bottomView.txtNext.addTarget(self, action: #selector(onClickNextVC), for: .touchUpInside)
        bottomView.btnBack.addTarget(self, action: #selector(previousViewController), for: .touchUpInside)
        bottomView.btnNext.isHidden = true
        bottomView.txtNext.isHidden = true
        
        btnNotSure.addTarget(self, action: #selector(onClickNotSureTouchUpInside), for: .touchUpInside)
    }
    
    func callFbLoginAPI(){
        showActivityIndicator(uiView: self.view)
        
        let fbloginID = getStringUserDefaultValue(key: .fbLoginID)
        let fbName = getStringUserDefaultValue(key: .fbName)
        let wantChild = getIntegerUserDefaultValue(key: .wantChild)
        
        let params = ["login_id": fbloginID ,"login_type" : loginType.facebook.rawValue ,"name" : fbName ,"children_status" : wantChild] as [String : Any]
        
        self.viewModel.calFBLoginAPI(params: params) { (response, isFinished, error) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
//               Note Here I Have To Check that gender is availble or not
//               Note Captain Stop Here 
                self.pushViewController(controllerID: .TellAboutYouVC, storyBoardID: .Main)
            }
            else{
                self.showAlert(message: error)
            }
        }
    }
    
    @IBAction func onClickYesTouchUpInside(){
        if !isNextTapped {
            let vc = ErrorMessageViewController()
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: false, completion: nil)
        }
        else{
            setIntegerUserDefaultValue(value: 1, key: .wantChild)
            if getBoolUserDefaultValue(key: .isFbLogin) {
                callFbLoginAPI()
            }
            else{
                self.pushViewController(controllerID: .SignUpVC, storyBoardID: .Main)
            }
        }
//
    }
    
    @IBAction func onClickNoTouchUpInside() {
        if isNextTapped {
//            call API To get Data
            setIntegerUserDefaultValue(value: 2, key: .wantChild)
            if getBoolUserDefaultValue(key: .isFbLogin) {
                callFbLoginAPI()
            }
            else{
                self.pushViewController(controllerID: .SignUpVC, storyBoardID: .Main)
            }
        }
        else{
            isNextTapped = true
            btnNotSure.isHidden = false
            btnYes.setTitleColor(.appDarkGreen, for: .normal)
            btnNo.setTitleColor(.tagViewBlueColor, for: .normal)
            btnNotSure.setTitleColor(.tagViewCyanColor, for: .normal)
            
            btnNotSure.setTitle(localizedString.notSure.getLocalizableString(), for: .normal)
            
            btnYes.setBorder(1 , UIColor.appDarkGreen)
            btnNo.setBorder(1 , UIColor.tagViewBlueColor)
            btnNotSure.setBorder(1 , UIColor.tagViewCyanColor)
            lblQuestion.text = localizedString.wantChild.getLocalizableString()
        }
    }
    
    @objc func onClickNotSureTouchUpInside(){
        setIntegerUserDefaultValue(value: 3, key: .wantChild)
        if getBoolUserDefaultValue(key: .isFbLogin) {
            callFbLoginAPI()
        }
        else{
            self.pushViewController(controllerID: .SignUpVC, storyBoardID: .Main)
        }
    }
    
    @objc func onClickNextVC(){
        
    }
    @objc func previousViewController(){
        self.popViewController()
    }
}
