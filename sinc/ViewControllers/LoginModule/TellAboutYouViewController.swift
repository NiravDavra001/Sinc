//
//  TellAboutYouViewController.swift
//  sinc
//
//  Created by mac on 04/02/21.
//

import UIKit
import KMPlaceholderTextView



class TellAboutYouViewController: UIViewController {
    
    @IBOutlet weak var lblYourSelf: UILabel!
    @IBOutlet weak var genderView: EditProfileCellView!
    @IBOutlet weak var birthView: GenralDatePicker!
    @IBOutlet weak var heightView: EditProfileCellView!
    @IBOutlet weak var bioViiew: UIView!
    @IBOutlet weak var bottomNavPanel: BottomNavPannel!

    @IBOutlet weak var petsView: ReligionView!
    @IBOutlet weak var smokeView: ReligionView!
    @IBOutlet weak var alcoholView: ReligionView!
    @IBOutlet weak var religionView: ReligionView!
//    GenralDatePicker
    @IBOutlet weak var txtViewBio: KMPlaceholderTextView!

    @IBOutlet weak var sexualOrientation: ReligionView!
    @IBOutlet weak var wantGederTypeView: ReligionView!
    @IBOutlet weak var kindOfRelationView: ReligionView!
    @IBOutlet weak var educationView: ReligionView!
    
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var txtProfession: UITextField!
    @IBOutlet weak var bioHeightConstraint: NSLayoutConstraint!
    
    var pickerView = genralPickerView()
    var heightPicker = genralPickerView()
    var datePickerView = UIDatePicker()
    var genderType = ["Female" , "Male"]
    var heightOfPerson = [String]()
    var viewModel = UpdateProfileViewModel()
    var dateOfBirth : Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        religionView.delegate = self
        petsView.delegate = self
        smokeView.delegate = self
        alcoholView.delegate = self
        pickerView.delegate = self
        heightPicker.delegate = self
        
        let height = (121...204).map { $0 * 1 }
        heightOfPerson = height.map { String($0) }
        
        pickerView.dataSource = genderType
        heightPicker.dataSource = heightOfPerson
        
        lblProfession.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
        txtProfession.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        txtProfession.placeholder = localizedString.enterProfession.getLocalizableString()
        
        religionView.setArrayItem(title: localizedString.religion.getLocalizableString(), profileType: .religion)
        
        petsView.setArrayItem(title: localizedString.questionPets.getLocalizableString(), profileType: .pets)
        
        smokeView.setArrayItem(title: localizedString.questionSmoke.getLocalizableString(), profileType: .smoking)
        
        alcoholView.setArrayItem(title: localizedString.questionDrink.getLocalizableString(), profileType: .drinking)
        
        sexualOrientation.delegate = self
        sexualOrientation.setArrayItem(title: localizedString.sexualType.getLocalizableString(), profileType: .sexual)
        
        educationView.delegate = self
        educationView.setArrayItem(title: localizedString.Education.getLocalizableString(), profileType: .education)
        
        kindOfRelationView.delegate = self
        kindOfRelationView.setArrayItem(title: localizedString.questionLookingFor.getLocalizableString(), profileType: .relationShipStatus)
        
        wantGederTypeView.delegate = self
        wantGederTypeView.setArrayItem(title: localizedString.wantToSee.getLocalizableString(), profileType: .wantGender)

        
        heightView.txtField.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        heightView.setButtonImage(imageName: "downArrow")
        heightView.setTitleOfLabel(text: "Height")
        
        genderView.txtField.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_14.rawValue))
        
        lblYourSelf.font = UIFont(name: FontName.Bold.rawValue, size: CustomFontSize(size: FontSize.Size_20.rawValue))
        
        let date = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        let DateInFormat = formatDate(date: date)
        
        
        heightView.txtField.placeholder = heightOfPerson[0]
        
        bottomNavPanel.btnNext.addTarget(self, action: #selector(onClickNextTopuchUpInside), for: .touchUpInside)
        bottomNavPanel.btnBack.addTarget(self, action: #selector(previousViewController), for: .touchUpInside)
        
        self.view.manageKeyboard()
        
        birthView.datePicker.datePickerMode = .date
        birthView.datePicker.setDate(date ?? Date(), animated: false)
        birthView.datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        birthView.datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        
        if #available(iOS 13.4, *) {
            birthView.datePicker.preferredDatePickerStyle = .compact
        } else {
            // Fallback on earlier versions
            
        }
        
        genderView.txtField.inputView = pickerView.pickerView
        heightView.txtField.inputView = heightPicker.pickerView
        birthView.datePicker.addTarget(self, action: #selector(selectBirthdate), for: .valueChanged)
        
    }
    
    @objc func onClickNextTopuchUpInside(){
        let str = petsView.checkIsSelectedOrNot()
        registerDetails.isPets = str
        registerDetails.bio = txtViewBio.text
        registerDetails.height = heightView.txtField.text
        
        if birthView.datePicker.date != Date() {
            dateOfBirth = birthView.datePicker.date
            let timeStamp = dateOfBirth?.timeIntervalSince1970
            registerDetails.dateOfBirth = Int(timeStamp ?? 0)
        }
        
        let profession = txtProfession.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        registerDetails.profession = profession
        
        if !viewModel.validateData(viewController: self) {
            return
        }
        
        showActivityIndicator(uiView: self.view)
        viewModel.callUpdateProfileAPI(completion: { (isFinished,error)  in
            if isFinished {
                self.pushViewController(controllerID: .UpdatePhotosVC, storyBoardID: .Main)
            }
            else{
                self.showAlert(message: error)
            }
            hideActivityIndicator(uiView: self.view)
        })
    }
    
    @objc func previousViewController(){
        self.popViewController()
    }
    
    @objc func selectBirthdate(_ sender : Any){
//        birthView.txtField.text = formatDate(date: datePickerView.date)
//        dateOfBirth =
    }
    
    func formatDate(date : Date?) -> String{
        dateOfBirth = birthView.datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let strDate = dateFormatter.string(from: birthView.datePicker.date)
        return strDate
    }
}

extension TellAboutYouViewController : ReligionCollectionViewDelegate{
    func reloadCollectionView(curCellIndex: Int,sender : UICollectionView) {
        sender.reloadData()
        if sender == religionView.collectionView {
            registerDetails.religion = curCellIndex + 1
        }else if sender == smokeView.collectionView {
            registerDetails.isSmoke = curCellIndex + 1
        }else if sender == alcoholView.collectionView {
            registerDetails.isAlcohol = curCellIndex + 1
        }else if sender == petsView.collectionView {
            printLog(string: "register Details : ", data: registerDetails.isPets ?? [""])
        }else if sender == sexualOrientation.collectionView {
            registerDetails.sexual_orientation = "\(curCellIndex + 1)"
        }else if sender == kindOfRelationView.collectionView {
            registerDetails.looking_for = "\(curCellIndex + 1)"
        }else if sender == educationView.collectionView {
            registerDetails.education = "\(curCellIndex + 1)"
        }else if sender == wantGederTypeView.collectionView {
            registerDetails.interest_in = "\(curCellIndex + 1)"
        }
    }
}

extension TellAboutYouViewController : genralPickerViewDelegate{
    func setIndexOfPicker(str: String, picker: UIPickerView, txtField: UITextField? , index : Int) {
        if picker == pickerView.pickerView {
            self.genderView.txtField.text = str
            
            if genderView.txtField.text == genderType[0] {
                registerDetails.gender = 1
            }
            else{
                registerDetails.gender = 2
            }
        }
        else if picker == heightPicker.pickerView{
            self.heightView.txtField.text = str
        }
    }
    
    
}

