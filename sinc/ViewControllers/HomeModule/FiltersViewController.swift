//
//  FiltersViewController.swift
//  sinc
//
//  Created by mac on 25/03/21.
//

import UIKit

class FiltersViewController: UIViewController {
    
    
    @IBOutlet weak var ageRangeSlider: RangeSliderView!
    @IBOutlet weak var heightSlider: RangeSliderView!
    @IBOutlet weak var lblPremiumFilters: UILabel!
    @IBOutlet weak var btnPremium: UIButton!
    @IBOutlet weak var premiumView: UIView!
    
    @IBOutlet weak var religionView: ReligionView!
    @IBOutlet weak var smokeView: ReligionView!
    @IBOutlet weak var alchoholView: ReligionView!
    @IBOutlet weak var relationView: ReligionView!
    @IBOutlet weak var sexualOrientationView: ReligionView!
    @IBOutlet weak var educationview: ReligionView!
    @IBOutlet weak var myFantacyView: ReligionView!
    @IBOutlet weak var petsView: ReligionView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnApplyFilter: UIButton!
    
    var cellType : profileDetails?
    
    var arrSearchDetails = [localizedString.religion.getLocalizableString(),localizedString.questionPets.getLocalizableString(),localizedString.questionSmoke.getLocalizableString(),localizedString.questionDrink.getLocalizableString(),localizedString.sexualType.getLocalizableString(),localizedString.Education.getLocalizableString(),localizedString.wantToSee.getLocalizableString(),localizedString.questionLookingFor.getLocalizableString()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        ageRangeSlider.delegate = self
        ageRangeSlider.distaceBetweenThumbs = 4
        ageRangeSlider.startIndex = 18
        ageRangeSlider.lastIndex = 60
        ageRangeSlider.totalPercentage = 60
        ageRangeSlider.applyGestures()
        ageRangeSlider.leftThumbImageView.isUserInteractionEnabled = true
        ageRangeSlider.rightThumbImageView.isUserInteractionEnabled = true
        
        heightSlider.delegate = self
        heightSlider.applyGestures()
        heightSlider.distaceBetweenThumbs = 15
        heightSlider.startIndex = 121
        heightSlider.totalPercentage = 224
        heightSlider.lastIndex = 224
        heightSlider.leftThumbImageView.isUserInteractionEnabled = true
        heightSlider.rightThumbImageView.isUserInteractionEnabled = true
        
        religionView.isUserInteractionEnabled = false
        smokeView.isUserInteractionEnabled = false
        alchoholView.isUserInteractionEnabled = false
        relationView.isUserInteractionEnabled = false
        sexualOrientationView.isUserInteractionEnabled = false
        educationview.isUserInteractionEnabled = false
        myFantacyView.isUserInteractionEnabled = false
        petsView.isUserInteractionEnabled = false
        
        setTitleForCustomViews()
        setDataToDiffCatagory()
        setUpNavigationBar()
    }
    
    func setUpNavigationBar(){
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let closeBtn  = UIButton(frame: CGRect(x: 0, y: 0, width: 12 * UIScreen.main.bounds.width / 375, height: 12 * UIScreen.main.bounds.width / 375))
        closeBtn.setImage(UIImage(named: "Close"), for: .normal)
        closeBtn.tintColor = .black
        closeBtn.addTarget(self, action: #selector(onTapClose), for: .touchUpInside)
        navigationItem.setLeftBarButtonItems([UIBarButtonItem(customView: closeBtn)], animated: false)
        
        
        let clearBtn  = UIButton(frame: CGRect(x: 0, y: 0, width: 50 * UIScreen.main.bounds.width / 375, height: 22 * UIScreen.main.bounds.height / 812))
        clearBtn.setTitle("Clear", for: .normal)
        clearBtn.setTitleColor(.black, for: .normal)
        clearBtn.addTarget(self, action: #selector(onTapClear), for: .touchUpInside)
        navigationItem.setRightBarButtonItems([UIBarButtonItem(customView: clearBtn)], animated: false)
    }
    
    @objc func onTapClose(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        self.popViewController()
    }
    
    @objc func onTapClear(){
        registerDetails = RegisterDetails()
        ageRangeSlider.startIndex = 18
        ageRangeSlider.lastIndex = 60
        
        heightSlider.startIndex = 121
        heightSlider.lastIndex = 221
        
        ageRangeSlider.resetRangeSlider()
        heightSlider.resetRangeSlider()
        
        religionView.arrReligion.removeAll()
        smokeView.arrReligion.removeAll()
        alchoholView.arrReligion.removeAll()
        relationView.arrReligion.removeAll()
        sexualOrientationView.arrReligion.removeAll()
        educationview.arrReligion.removeAll()
        myFantacyView.arrReligion.removeAll()
        petsView.arrReligion.removeAll()
        
        setDataToDiffCatagory()
        
        religionView.collectionView.reloadData()
        smokeView.collectionView.reloadData()
        alchoholView.collectionView.reloadData()
        relationView.collectionView.reloadData()
        sexualOrientationView.collectionView.reloadData()
        educationview.collectionView.reloadData()
        myFantacyView.collectionView.reloadData()
        petsView.collectionView.reloadData()
    }
    
    func setDataToDiffCatagory(){
        religionView.delegate = self
        religionView.setArrayItem(title: localizedString.religion.getLocalizableString(), profileType: .religion)
        
        petsView.delegate = self
        petsView.setArrayItem(title: localizedString.questionPets.getLocalizableString(), profileType: .pets)
        
        smokeView.delegate = self
        smokeView.setArrayItem(title: localizedString.questionSmoke.getLocalizableString(), profileType: .smoking)
        
        alchoholView.delegate = self
        alchoholView.setArrayItem(title: localizedString.questionDrink.getLocalizableString(), profileType: .drinking)
        
        sexualOrientationView.delegate = self
        sexualOrientationView.setArrayItem(title: localizedString.sexualType.getLocalizableString(), profileType: .sexual)
        
        educationview.delegate = self
        educationview.setArrayItem(title: localizedString.Education.getLocalizableString(), profileType: .education)
        
        myFantacyView.delegate = self
        myFantacyView.setArrayItem(title: localizedString.wantToSee.getLocalizableString(), profileType: .wantGender)
        
        relationView.delegate = self
        relationView.setArrayItem(title: localizedString.questionLookingFor.getLocalizableString(), profileType: .relationShipStatus)
        
        
        
    }
    
    func setTitleForCustomViews(){
        
        ageRangeSlider.lblTitle.text = "Age Range"
        heightSlider.lblTitle.text = "Height"
        btnPremium.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        lblPremiumFilters.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_14.rawValue)
        btnApplyFilter.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
    }
    
    @IBAction func onTapGoPremium(_ sender: Any) {
//        PremiumFeaturesPopupViewController
        self.presentViewController(controllerID: .PremiumFeaturesPopupVC, storyBoardID: .Setting)
    }
    
    
    @IBAction func onTapApplyFilters(_ sender: Any) {
        let str = petsView.checkIsSelectedOrNot()
        if str != ""{
            registerDetails.isPets = str
        }
        
        
        UserDefaultManager.share.storeModelToUserDefault(userData: registerDetails, key: .storeUserFilterData)
       
    }
    
    override func viewDidLayoutSubviews() {
        btnPremium.setRoundedView()
        btnApplyFilter.setRoundedView()
    }
    
    func setHideUnhideViews(hidden : Bool , title : String? = nil){
        religionView.isHidden = hidden
        smokeView.isHidden = hidden
        alchoholView.isHidden = hidden
        relationView.isHidden = hidden
        sexualOrientationView.isHidden = hidden
        educationview.isHidden = hidden
        myFantacyView.isHidden = hidden
        petsView.isHidden = hidden
        ageRangeSlider.isHidden = hidden
        heightSlider.isHidden = hidden
        premiumView.isHidden = hidden
        if title != nil {
            if religionView.titleLabel.text?.contains(title!) == true {
                religionView.isHidden = !hidden
            }
            if religionView.titleLabel.text?.contains(title!) == true {
                smokeView.isHidden = !hidden
            }
            if alchoholView.titleLabel.text?.contains(title!) == true {
                alchoholView.isHidden = !hidden
            }
            if relationView.titleLabel.text?.contains(title!) == true {
                relationView.isHidden = !hidden
            }
            if sexualOrientationView.titleLabel.text?.contains(title!) == true {
                sexualOrientationView.isHidden = !hidden
            }
            if educationview.titleLabel.text?.contains(title!) == true {
                educationview.isHidden = !hidden
            }
            if myFantacyView.titleLabel.text?.contains(title!) == true {
                myFantacyView.isHidden = !hidden
            }
            if petsView.titleLabel.text?.contains(title!) == true {
                petsView.isHidden = !hidden
            }
            if ageRangeSlider.lblTitle.text?.contains(title!) == true {
                ageRangeSlider.isHidden = !hidden
            }
            if heightSlider.lblTitle.text?.contains(title!) == true {
                heightSlider.isHidden = !hidden
            }
        }
    }
}

extension FiltersViewController:RangeSliderViewDelegate{
    func getRagneBetweenThumb(startRange: Int, endRange: Int,slider : RangeSliderView) {
        if slider == ageRangeSlider {
            registerDetails.minAge = "\(startRange)"
            registerDetails.maxAge = "\(endRange)"
        }
        else{
            registerDetails.minHeight = "\(startRange)"
            registerDetails.maxHeight = "\(endRange)"
        }
    }
}

extension FiltersViewController : ReligionCollectionViewDelegate{
    func reloadCollectionView(curCellIndex: Int, sender: UICollectionView) {
        sender.reloadData()
        if sender == religionView.collectionView {
            registerDetails.religion = curCellIndex + 1
        }
        else if sender == smokeView.collectionView {
            registerDetails.isSmoke = curCellIndex + 1
        }
        else if sender == alchoholView.collectionView {
            registerDetails.isAlcohol = curCellIndex + 1
        }
        else if sender == petsView.collectionView {
            printLog(string: "register Details : ", data: registerDetails.isPets ?? [""])
        }
        else if sender == sexualOrientationView.collectionView {
            registerDetails.sexual_orientation = "\(curCellIndex + 1)"
        }
        else if sender == religionView.collectionView {
            registerDetails.looking_for = "\(curCellIndex + 1)"
        }
        else if sender == educationview.collectionView {
            registerDetails.education = "\(curCellIndex + 1)"
        }
        else if sender == myFantacyView.collectionView {
            registerDetails.interest_in = "\(curCellIndex + 1)"
        }
    }
}
extension FiltersViewController : UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.setHideUnhideViews(hidden: false)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.setHideUnhideViews(hidden: false)
        }
        for i in 0..<(arrSearchDetails.count) {
            if arrSearchDetails[i].contains(searchText){
                self.setHideUnhideViews(hidden: true,title: searchText)
            }
        }
    }
}
