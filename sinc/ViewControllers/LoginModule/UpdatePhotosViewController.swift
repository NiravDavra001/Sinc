//
//  UpdatePhotosViewController.swift
//  sinc
//
//  Created by mac on 06/02/21.
//

import UIKit


class UpdatePhotosViewController: UIViewController {
    
    @IBOutlet weak var bottomNavPanel: BottomNavPannel!
    @IBOutlet weak var gallaryBtn:AppButtonView!
    @IBOutlet weak var fbGallaryBtn:AppButtonView!
    
    @IBOutlet weak var profileImg: UIImageView!
    var imgPicker : ImagePicker!
    
    var viewModel = UpdatePhotosViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        profileImg.image = UIImage(named: "Profile")
    }
    
    
    
    override func viewDidLayoutSubviews() {
        profileImg.layer.cornerRadius = profileImg.bounds.width / 2
        profileImg.clipsToBounds = true
        fbGallaryBtn.setButton(name: "upload from camera", imageName: "CameraIcon", isGradiant: false)
        fbGallaryBtn.image.tintColor = .appLightGreen
        gallaryBtn.setButton(name: "upload from gallery", imageName: "chooseFromGallery",isGradiant: false)
    }
    func setupUI(){
        gallaryBtn.Button.addTarget(self, action: #selector(onClickOpenGallery), for: .touchUpInside)
        bottomNavPanel.btnNext.addTarget(self, action: #selector(onClickNextTopuchUpInside), for: .touchUpInside)
        bottomNavPanel.btnBack.addTarget(self, action: #selector(previousViewController), for: .touchUpInside)
        
        gallaryBtn.setButtonNameRightSide()
        fbGallaryBtn.setButtonNameRightSide()
        
        fbGallaryBtn.Button.addTarget(self, action: #selector(onClickOpenCamera), for: .touchUpInside)
        profileImg.contentMode = .scaleToFill
        imgPicker = ImagePicker.init(presentationController: self, delegate: self)
    }

    @objc func onClickOpenGallery(){
        imgPicker.action(for: .photoLibrary, title: "")
    }
    @objc func onClickOpenCamera(){
        imgPicker.action(for: .camera, title: "")
    }
    
    @objc func onClickNextTopuchUpInside(){
        if profileImg.image == UIImage(named: "Profile") {
            self.showAlert(message: localizedString.insertPicture.getLocalizableString())
            return
        }
        
        let data = profileImg.image?.jpegData(compressionQuality: 1.0) ?? Data()
        registerDetails = RegisterDetails(image1: data)
        if registerDetails.image1 == nil || registerDetails.image1?.isEmpty ?? false{
            self.showAlert(message: localizedString.insertPicture.getLocalizableString())
        }
        
        showActivityIndicator(uiView: self.view)
        viewModel.callUpdateImageAPI { (isFinished,error) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.pushViewController(controllerID: .InterestsVC, storyBoardID: .Main)
            }
            else{
                self.showAlert(message: error)
            }
        }
    }
    
    @objc func previousViewController(){
        self.popViewController()
    }

}

extension UpdatePhotosViewController:ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        profileImg.image = image
    }
}


