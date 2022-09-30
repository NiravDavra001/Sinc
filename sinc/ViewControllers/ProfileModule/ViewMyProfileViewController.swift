//
//  ViewMyProfileViewController.swift
//  sinc
//
//  Created by mac on 26/03/21.
//

import UIKit
import collection_view_layouts

class ViewMyProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblIntrest: UILabel!
    @IBOutlet weak var lblCommon: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblMarialStatus: UILabel!
    @IBOutlet weak var lblSmoke: UILabel!
    @IBOutlet weak var lblDrink: UILabel!
    @IBOutlet weak var lblReligion: UILabel!
    
    @IBOutlet weak var intrestMainView: UIView!
    @IBOutlet weak var interstView: TagsColletionView!
    
    @IBOutlet weak var usernameSepraterView: UIView!
    @IBOutlet weak var userPersonaldetailsSepraterView: UIView!
    @IBOutlet weak var userIntrstSepraterView: UIView!
    @IBOutlet weak var userBioSepraterView: UIView!
    let viewModel = ViewMyProfileViewModel()
    
    var arrMyIntrest = [Int]()
    var arrListOfUserData : UserServerInfo?
    var arrImageData = [String]()
    
    var layout: BaseLayout = TagsLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ProfilePagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfilePagingCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib(nibName: "IntrestsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IntrestsCollectionViewCell")
        setUpNavigationBar()
        setUPUI()
        arrListOfUserData = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyProfileAPIs()
    }
    
    func setUpNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        
        let button  = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setTitle("Edit", for: .normal)
        button.titleLabel?.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        button.setButtonTitleGradiant(label: button.titleLabel ?? UILabel(), LeftColor: .appDarkGreen, RightColor: .appLightGreen)
        button.addTarget(self, action: #selector(onTapPopViewController), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func onClickEditProfileTouchupinside(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onTapPopViewController(){
        self.presentViewController(controllerID: .EditProfileVC, storyBoardID: .Profile)
    }
    
    func setUPUI(){
        lblName.font = UIFont(name: FontName.SemiBold.rawValue, size:  FontSize.Size_24.rawValue)
        
        lblOccupation.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        
        lblDistance.textColor = .buttonFontColor
        lblDistance.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_12.rawValue))
        
        lblBio.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        lblBio.textColor = .fontGrayColor2
        
        lblIntrest.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        
        lblCommon.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        lblCommon.textColor = .buttonFontColor
        
        lblInfo.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        
        lblIntrest.text = "Interest"
        lblCommon.text = ""
        
        usernameSepraterView.backgroundColor = .sepraterViewColor
        userPersonaldetailsSepraterView.backgroundColor = .sepraterViewColor
        userIntrstSepraterView.backgroundColor = .sepraterViewColor
        userBioSepraterView.backgroundColor = .sepraterViewColor
    }
    
    func getMyProfileAPIs(){
        showActivityIndicator(uiView: self.view)
        viewModel.callGetMyProfileDetailsAPI { [self] (isFinished, error) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.lblBio.text = self.viewModel.myProfile?.data?.bio
                self.lblName.text = (self.viewModel.myProfile?.data?.name ?? "") + "," + (self.viewModel.myProfile?.data?.age ?? "")
                
                self.lblOccupation.text = self.viewModel.myProfile?.data?.profession
                self.lblDrink.text = "Drink " + (self.viewModel.myProfile?.data?.profession ?? "")
                
                self.arrMyIntrest = (self.viewModel.myProfile?.data?.interest?.map{$0.interestId} as? [Int] ?? [0])
                
                let smokeDetails = ["Regularly","Occasionally","Does not smoke"]
                let userSmoke =  self.viewModel.myProfile?.data?.isSmoke ?? 0
                
                self.lblSmoke.attributedText = setAttributedText(text1 : "Smoke   " ,text2 : smokeDetails[userSmoke - 1],fontsize1 : FontSize.Size_12.rawValue,fontsize2 : FontSize.Size_12.rawValue,fontColor1 : .fontGrayColor3 , fontColor2 : .black, fontName1 : FontName.Regular.rawValue, fontName2 : FontName.Regular.rawValue)
                
                let drinkDetails = ["Regularly","Occasionally","Does not drink"]
                let userDrink =  self.viewModel.myProfile?.data?.isAlcohol ?? 0
                self.lblDrink.attributedText = setAttributedText(text1 : "Drink   " ,text2 : drinkDetails[userDrink - 1],fontsize1 : FontSize.Size_12.rawValue,fontsize2 : FontSize.Size_12.rawValue,fontColor1 : .fontGrayColor3 , fontColor2 : .black, fontName1 : FontName.Regular.rawValue, fontName2 : FontName.Regular.rawValue)
                
                let userReligion = Int(self.viewModel.myProfile?.data?.religion ?? "0")
                self.lblReligion.attributedText = setAttributedText(text1 : "Religion   " ,text2 :(arrListOfUserData?.religion?[(userReligion ?? 0) - 1].value ?? ""),fontsize1 : FontSize.Size_12.rawValue,fontsize2 : FontSize.Size_12.rawValue,fontColor1 : .fontGrayColor3 , fontColor2 : .black, fontName1 : FontName.Regular.rawValue, fontName2 : FontName.Regular.rawValue)
                
                
                var demoData = [String]()
                var demoColor = [String]()
                for i in 0..<(self.arrMyIntrest.count) {
                    let str = arrListOfUserData?.interest?[arrMyIntrest[i] - 1].value
                    demoData.append(str ?? "")
                    let color = arrListOfUserData?.interest?[arrMyIntrest[i] - 1].colorID
                    demoColor.append(color ?? "")
                }
                arrImageData.removeAll()
                for i in 0..<(self.viewModel.myProfile?.data?.image?.count ?? 0){
                    if self.viewModel.myProfile?.data?.image?[i].image != "" {
                        arrImageData.append(self.viewModel.myProfile?.data?.image?[i].image ?? "")
                    }
                }
                self.collectionView.reloadData()
                
                self.interstView.setData(data: demoData, color: demoColor)
                self.interstView.lblTItle.text = ""
                self.interstView.btnDwon.isHidden = true
                self.interstView.collectionView.isScrollEnabled = false
                self.intrestMainView.layoutIfNeeded()
                self.interstView.layoutIfNeeded()
                self.interstView.collectionView.reloadData()
                self.view.setNeedsLayout()
                
                //                self.intrestCollectionView.reloadData()
            }
            else{
                self.showAlert(message: error)
            }
        }
    }
}

extension ViewMyProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePagingCollectionViewCell", for: indexPath) as? ProfilePagingCollectionViewCell
        print("data is  : ",arrImageData[indexPath.row])
        cell?.imageView.sd_setImage(with: URL(string: arrImageData[indexPath.row]), completed: nil)
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
        
    }
}
