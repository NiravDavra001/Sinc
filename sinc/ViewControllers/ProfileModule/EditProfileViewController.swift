
//
//  EditProfileViewController.swift
//  SincDemo
//
//  Created by pc on 10/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit
//import EventKit

class EditProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var userNameView: EditProfileCellView!
    @IBOutlet weak var birthView: GenralDatePicker!
    @IBOutlet weak var genderView: EditProfileCellView!
    @IBOutlet weak var sexualView: EditProfileCellView!
    @IBOutlet weak var myFantacyView: EditProfileCellView!
    @IBOutlet weak var relationVIew: EditProfileCellView!
    @IBOutlet weak var heihgtView: EditProfileCellView!
    @IBOutlet weak var educationView: EditProfileCellView!
    @IBOutlet weak var petsView: EditProfileCellView!
    @IBOutlet weak var religionView: EditProfileCellView!
    @IBOutlet weak var smokeView: EditProfileCellView!
    @IBOutlet weak var alcoholView: EditProfileCellView!
    @IBOutlet weak var professtionView: EditProfileCellView!
    
    @IBOutlet weak var intrestsView: TagsColletionView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCancle: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var imgPicker : ImagePicker!
    
    //    @IBOutlet weak var intrestView: TagsColletionView!
    
    let viewModel = EditProfileViewModel()
    
    
    var arrCombineImage = [Data]()
    var arrImage = ["","","","","",""]
    
    var currentIndexPath = IndexPath()
    
    lazy var catagoryArray = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)
    
    var datePicker = UIDatePicker()
    var pickerView = genralPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "editProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "editProfileCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createCollectionViewLayout()
        
        pickerView.delegate = self
        btnCancle.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        btnSave.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        
        btnSave.setButtonTitleGradiant(label: btnSave.titleLabel ?? UILabel(), LeftColor: .appLightGreen, RightColor: .appDarkGreen)
        
        imgPicker = ImagePicker.init(presentationController: self, delegate: self)
        
        self.intrestsView.setEditHiddenUnhidden(hidden: false)
        self.intrestsView.isUserInteractionEnabled = true
        self.intrestsView.btnEdit.addTarget(self, action: #selector(onTapAddOrRemoveIntrests), for: .touchUpInside)
        
        collectionView.isScrollEnabled = false
        
        intrestsView.titleView.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
        applyTitle()
        applyPickerToTxtFeild()
        getMyProfileAPI()
    }
    
    @objc func onClickOpenGallery(){
        imgPicker.action(for: .photoLibrary, title: "")
    }
    @objc func onClickOpenCamera(){
        imgPicker.action(for: .camera, title: "")
    }
    
    func getMyProfileAPI(){
        viewModel.callGetMyProfileDetailsAPI { (isFinised, message) in
            if isFinised{
                self.userNameView.txtField.text = self.viewModel.myProfile?.data?.name
                self.professtionView.txtField.text = self.viewModel.myProfile?.data?.profession

                setUserDataAsPerView(index: self.viewModel.myProfile?.data?.gender ?? 0, txtField: self.genderView.txtField, title: "", txtType: "gender")
                
                setUserDataAsPerView(index: Int(), txtField: self.sexualView.txtField, title: self.viewModel.myProfile?.data?.sexualOrientation ?? "0", txtType: "sexual")
                
                setUserDataAsPerView(index: Int(), txtField: self.myFantacyView.txtField, title: self.viewModel.myProfile?.data?.interestIn ?? "0", txtType: "fantacy")
                
                setUserDataAsPerView(index: Int(), txtField: self.relationVIew.txtField, title: self.viewModel.myProfile?.data?.lookingFor ?? "0", txtType: "lookingFor")
                
                setUserDataAsPerView(index: Int(), txtField: self.heihgtView.txtField, title: self.viewModel.myProfile?.data?.height ?? "0", txtType: "height")
                
                setUserDataAsPerView(index: Int(), txtField: self.educationView.txtField, title: self.viewModel.myProfile?.data?.education ?? "0", txtType: "education")
                
                setUserDataAsPerView(index: Int(), txtField: self.petsView.txtField, title: self.viewModel.myProfile?.data?.isPets ?? "0", txtType: "pets")
                
                setUserDataAsPerView(index: Int(), txtField: self.religionView.txtField, title: self.viewModel.myProfile?.data?.religion ?? "0", txtType: "religion")
                
                setUserDataAsPerView(index: self.viewModel.myProfile?.data?.isSmoke ?? 0, txtField: self.smokeView.txtField, title: "", txtType: "smoke")
                
                setUserDataAsPerView(index: self.viewModel.myProfile?.data?.isAlcohol ?? 0, txtField: self.alcoholView.txtField, title: "", txtType: "alchohol")
                
                let DOB = self.viewModel.myProfile?.data?.dateOfBirth
                let dateFormatter = DateFormatter()

                dateFormatter.dateFormat = "yy-MM-dd"
                let dateOB = dateFormatter.date(from: DOB ?? "")
                self.birthView.datePicker.date = dateOB ?? Date()
                
                
                let arr = self.viewModel.myProfile?.data?.interest?.map{$0.interestId ?? 0}
                let data = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)?.interest
                
                var arrColor = [String]()
                for i in 0..<(arr?.count ?? 0) {
                    arrColor.append(data?[i].colorID ?? "")
                }
                
                self.intrestsView.setData(data: getInterestOrHobbyOfUser(index: arr ?? [0]), color: arrColor)
                self.intrestsView.lblTItle.text = "Intrests"
                self.intrestsView.collectionView.reloadData()
                
                let images = self.viewModel.myProfile?.data?.image?.map{$0.image ?? ""} ?? [""]
                let arrIndex = self.viewModel.myProfile?.data?.image?.map{$0.sort ?? 0} ?? [0]
                for item in 0..<(arrIndex.count) {
                    self.arrImage.remove(at: (Int(arrIndex[item]) - 1) )
                    self.arrImage.insert(images[item], at: (Int(arrIndex[item]) - 1))
                }
                self.collectionView.reloadData()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func applyTitle(){
        birthView.lblTitle.text = "Birthdate"
        birthView.lblTitle.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        
        religionView.setTitleOfLabel(text: "Religion")
        smokeView.setTitleOfLabel(text:  "Smoke")
        alcoholView.setTitleOfLabel(text:  "Drink")
        professtionView.setTitleOfLabel(text:  "Profession")
        
        userNameView.setTitleOfLabel(text:  "Name")
        genderView.setTitleOfLabel(text:  "Gender")
        sexualView.setTitleOfLabel(text:  "Sexual Orientation")
        myFantacyView.setTitleOfLabel(text:  "Intrest In")
        relationVIew.setTitleOfLabel(text:  "Looking For")
        heihgtView.setTitleOfLabel(text:  "Height")
        educationView.setTitleOfLabel(text:  "Education")
        petsView.setTitleOfLabel(text:  "Pets")
        
        birthView.lblTitle.text = "Birthdate"
        
        userNameView.button.isHidden = true
        userNameView.txtField.placeholder = "Name"
        
        professtionView.button.isHidden = true
        
        birthView.lblTitle.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
    }
    
    @objc func onTapAddOrRemoveIntrests(){
        let VC = self.loadViewController(Storyboard:.Profile,ViewController:.SelectInstrestsVC) as! SelectInstrestsViewController
        let arr = self.viewModel.myProfile?.data?.interest?.map{$0.interestId ?? 0}
        VC.alreadySelectedInterst = arr ?? [0]
        self.present(VC, animated: true, completion: nil)
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onTapSave(_ sender: Any) {
        showActivityIndicator(uiView: self.view)
        viewModel.callEditAndUpdateProfile { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.dismissViewController()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func applyPickerToTxtFeild(){
        genderView.txtField.inputView = self.pickerView.pickerView
        sexualView.txtField.inputView = self.pickerView.pickerView
        myFantacyView.txtField.inputView = self.pickerView.pickerView
        relationVIew.txtField.inputView = self.pickerView.pickerView
        heihgtView.txtField.inputView = self.pickerView.pickerView
        educationView.txtField.inputView = self.pickerView.pickerView
        petsView.txtField.inputView = self.pickerView.pickerView
        religionView.txtField.inputView = self.pickerView.pickerView
        smokeView.txtField.inputView = self.pickerView.pickerView
        alcoholView.txtField.inputView = self.pickerView.pickerView
        
        genderView.txtField.delegate = self
        sexualView.txtField.delegate = self
        myFantacyView.txtField.delegate = self
        relationVIew.txtField.delegate = self
        heihgtView.txtField.delegate = self
        educationView.txtField.delegate = self
        petsView.txtField.delegate = self
        religionView.txtField.delegate = self
        smokeView.txtField.delegate = self
        alcoholView.txtField.delegate = self
    }

    func showDatePicker() {
        datePicker = UIDatePicker()
        datePicker.backgroundColor = .red
        datePicker.date = Date()
        datePicker.locale = .current
        datePicker.datePickerMode = .date
        datePicker.overrideUserInterfaceStyle = .dark
        self.view.addSubview(datePicker)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout{(sectionNumber, env) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let mainItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.66),
                        heightDimension: .fractionalHeight(1)))
                
                let pairItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(0.66)))
                
                
                let trailingGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.33),
                        heightDimension: .fractionalHeight(1)),
                    subitem: pairItem,
                    count: 2)
                
                let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.66)),
                    subitems: [mainItem, trailingGroup])
                
                let section = NSCollectionLayoutSection(group: mainWithPairGroup)
                return section
            }
            else {
                let tripletItem = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.33),
                        heightDimension: .fractionalHeight(1)))
                let tripletGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.33)),
                    subitems: [tripletItem, tripletItem, tripletItem])
                
                let section = NSCollectionLayoutSection(group: tripletGroup)
                return section
            }
        }
    }
    
    @objc func previousViewController(){
        self.popViewController()
    }
    
}

extension EditProfileViewController : UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }
        else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "editProfileCollectionViewCell", for: indexPath) as? editProfileCollectionViewCell
        cell?.delegate = self
        if indexPath.section == 0{
            cell?.index = indexPath.row
            if arrImage[indexPath.row] != "" {
                cell?.setImageWithURL(url: arrImage[indexPath.row])
                let imageData = cell?.imageView.image?.jpegData(compressionQuality: 0.5) ?? Data()
                if indexPath.row == 0 {
                    registerDetails.image1 = imageData
                }
                else if indexPath.row == 1 {
                    registerDetails.image2 = imageData
                }
                else if indexPath.row == 2 {
                    registerDetails.image3 = imageData
                }
            }
            else{
                cell?.imageView.image =  UIImage(named: "Add_Image")
            }
        }
        else if indexPath.section == 1{
            cell?.index = indexPath.row + 3
            if arrImage[indexPath.row + 3] != ""{
                cell?.setImageWithURL(url: arrImage[indexPath.row + 3])
                let imageData = cell?.imageView.image?.jpegData(compressionQuality: 0.5) ?? Data()
                if indexPath.row == 0 {
                    registerDetails.image4 = imageData
                }
                else if indexPath.row == 1 {
                    registerDetails.image5 = imageData
                }
                else if indexPath.row == 2 {
                    registerDetails.image6 = imageData
                }
            }
            else{
                cell?.imageView.image =  UIImage(named: "Add_Image")
            }
        }
        
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width,height: collectionView.bounds.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndexPath = indexPath
        let alert:UIAlertController = UIAlertController(title: nil,
                                                        message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { UIAlertAction in
            self.onClickOpenCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default) { UIAlertAction in
            self.onClickOpenGallery()
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension EditProfileViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case genderView.txtField:
            pickerView.dataSource.append("Female")
            pickerView.dataSource.append("Male")
            pickerView.currentTxtFeild = genderView.txtField
            pickerView.reloadPickerView()
        case sexualView.txtField:
            pickerView.dataSource.append(contentsOf: catagoryArray?.sexualOrientation?.map{($0.value ?? "")} ?? [""])
            pickerView.currentTxtFeild = sexualView.txtField
            pickerView.reloadPickerView()
            
        case myFantacyView.txtField:
            pickerView.dataSource.append("Female")
            pickerView.dataSource.append("Male")
            pickerView.currentTxtFeild = myFantacyView.txtField
            pickerView.reloadPickerView()
            
        case relationVIew.txtField:
            pickerView.dataSource.append(contentsOf: catagoryArray?.lookingFor?.map{($0.value ?? "")} ?? [""])
            pickerView.currentTxtFeild = relationVIew.txtField
            pickerView.reloadPickerView()
            
            
        case heihgtView.txtField:
            let height = (121...204).map { $0 * 1 }
            pickerView.dataSource.append(contentsOf: height.map { String($0) })
            pickerView.currentTxtFeild = heihgtView.txtField
            pickerView.reloadPickerView()
            
            
        case educationView.txtField:
            pickerView.dataSource.append(contentsOf: catagoryArray?.education?.map{($0.value ?? "")} ?? [""])
            pickerView.currentTxtFeild = educationView.txtField
            pickerView.reloadPickerView()
            
        case petsView.txtField:
            pickerView.dataSource.append(contentsOf: catagoryArray?.isPets?.map{($0.value ?? "")} ?? [""])
            pickerView.currentTxtFeild = petsView.txtField
            pickerView.reloadPickerView()
            
        case religionView.txtField:
            pickerView.dataSource.append(contentsOf: catagoryArray?.religion?.map{($0.value ?? "")} ?? [""])
            pickerView.currentTxtFeild = religionView.txtField
            pickerView.reloadPickerView()
            
            
        case smokeView.txtField:
            pickerView.dataSource.append("Regularly")
            pickerView.dataSource.append("Occasionally")
            pickerView.dataSource.append("Does not Smoke")
            pickerView.currentTxtFeild = smokeView.txtField
            pickerView.reloadPickerView()
            
            
        case alcoholView.txtField:
            pickerView.dataSource.append("Regularly")
            pickerView.dataSource.append("Occasionally")
            pickerView.dataSource.append("Does not Drink")
            pickerView.currentTxtFeild = alcoholView.txtField
            pickerView.reloadPickerView()
         
        default:
            break
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        pickerView.dataSource.removeAll()
        pickerView.reloadPickerView()
    }
}

extension EditProfileViewController: genralPickerViewDelegate{
    func setIndexOfPicker(str: String, picker: UIPickerView, txtField: UITextField? , index : Int) {
        switch txtField {
        case genderView.txtField:
            genderView.txtField.text = str
            registerDetails.gender = index + 1
           
        case religionView.txtField:
            religionView.txtField.text = str
            registerDetails.religion = index
        case relationVIew.txtField:
            relationVIew.txtField.text = str
            registerDetails.looking_for = "\(index)"
        case petsView.txtField:
            petsView.txtField.text = str
            registerDetails.isPets = "\(index)"
        case sexualView.txtField:
            sexualView.txtField.text = str
            registerDetails.sexual_orientation = "\(index)"
        case smokeView.txtField:
            smokeView.txtField.text = str
            registerDetails.isSmoke = index
        case alcoholView.txtField:
            alcoholView.txtField.text = str
            registerDetails.isAlcohol = index
        case heihgtView.txtField:
            heihgtView.txtField.text = str
            registerDetails.height = str
        case educationView.txtField:
            educationView.txtField.text = str
            registerDetails.education = "\(index)"
        case myFantacyView.txtField:
            myFantacyView.txtField.text = str
            registerDetails.interest_in = "\(index)"
        default:
            break
        }
        
    }
}
extension EditProfileViewController:ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        let cell =  self.collectionView.cellForItem(at: currentIndexPath) as? editProfileCollectionViewCell
        cell?.imageView.image = image
        cell?.btnRemoveImage.isHidden = false
        print("current Selected Image : ",currentIndexPath)
        
        if currentIndexPath.section == 0 {
            let data = cell?.imageView.image?.jpegData(compressionQuality: 0.5) ?? Data()
            if currentIndexPath.row == 0 {
                registerDetails.image1 = data
            }
            else if currentIndexPath.row == 1 {
                registerDetails.image2 = data
            }
            else if currentIndexPath.row == 2 {
                registerDetails.image3 = data
            }
        }
        else{
            let data = cell?.imageView.image?.jpegData(compressionQuality: 0.5) ?? Data()
            if currentIndexPath.row == 0 {
                registerDetails.image4 = data
            }
            else if currentIndexPath.row == 1 {
                registerDetails.image5 = data
            }
            else if currentIndexPath.row == 2 {
                registerDetails.image6 = data
            }
        }
    }
}
extension EditProfileViewController : EditProfileCollectionViewCellDelegate {
    func onTapRemoveImageData(index: Int) {
        if index == 0{
            registerDetails.image1 = Data()
        }
        if index == 1{
            registerDetails.image2 = Data()
        }
        if index == 2{
            registerDetails.image3 = Data()
        }
        if index == 3{
            registerDetails.image4 = Data()
        }
        if index == 4{
            registerDetails.image5 = Data()
        }
        if index == 5{
            registerDetails.image6 = Data()
        }
    }
}
