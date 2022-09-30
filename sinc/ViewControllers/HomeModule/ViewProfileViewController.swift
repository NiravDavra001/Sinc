//
//  ViewProfileViewController.swift
//  SincDemo
//
//  Created by pc on 11/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit
import collection_view_layouts

class ViewProfileViewController: UIViewController {
    
    
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
    
    
    @IBOutlet weak var intrestView: TagsColletionView!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var btnLike: UIButton!
    
    @IBOutlet weak var btnDisLike: UIButton!
    @IBOutlet weak var disLiekView: UIView!
    
    
    var arrMyIntrest = [Int]()
    var arrListOfUserData : UserServerInfo?
    var arrImageData = [String]()
    
    var userID : Int?
    
    var viewModel = ViewProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ProfilePagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProfilePagingCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource =  self
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib(nibName: "IntrestsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IntrestsCollectionViewCell")
        
        arrListOfUserData = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        setUPUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyProfile()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func commonMatches() -> Int{
        let userInterest = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)?.interest?.map{$0.id}
        let secondUserInterst = self.viewModel.userData?.data?.interest?.map{$0.interestId}
        var count = 0
        for i in userInterest! {
            for j in secondUserInterst! {
                if i == j {
                    count = count + 1
                }
            }
        }
        print("total count is : ",count)
        return count
    }
    
    func getMyProfile(){
        showActivityIndicator(uiView: self.view)
        viewModel.callAnotherUserProfile(userID: self.userID ?? 0) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.lblBio.text = self.viewModel.userData?.data?.bio
                self.lblName.text = (self.viewModel.userData?.data?.name ?? "") + "," + (self.viewModel.userData?.data?.age ?? "")
                
                let totalcount = self.commonMatches()
                
                self.lblOccupation.text = self.viewModel.userData?.data?.profession
                self.lblDrink.text = "Drink " + (self.viewModel.userData?.data?.profession ?? "")
                
                self.arrMyIntrest = (self.viewModel.userData?.data?.interest?.map{$0.interestId} as? [Int] ?? [0])
                
                let smokeDetails = ["Regularly","Occasionally","Does not smoke"]
                var userSmoke =  self.viewModel.userData?.data?.isSmoke ?? 0
                if userSmoke == 3 {
                    userSmoke = 2
                }
                self.lblSmoke.attributedText = setAttributedText(text1 : "Smoke   " ,text2 : smokeDetails[userSmoke],fontsize1 : FontSize.Size_12.rawValue,fontsize2 : FontSize.Size_12.rawValue,fontColor1 : .fontGrayColor3 , fontColor2 : .black, fontName1 : FontName.Regular.rawValue, fontName2 : FontName.Regular.rawValue)
                
                let drinkDetails = ["Regularly","Occasionally","Does not drink"]
                var userDrink =  self.viewModel.userData?.data?.isAlcohol ?? 0
                if userDrink == 3 {
                    userDrink = 2
                }
                self.lblDrink.attributedText = setAttributedText(text1 : "Drink   " ,text2 : drinkDetails[userDrink],fontsize1 : FontSize.Size_12.rawValue,fontsize2 : FontSize.Size_12.rawValue,fontColor1 : .fontGrayColor3 , fontColor2 : .black, fontName1 : FontName.Regular.rawValue, fontName2 : FontName.Regular.rawValue)
                
                var userReligion = Int(self.viewModel.userData?.data?.religion ?? "0")
                if userReligion == self.arrListOfUserData?.religion?.count {
                    userReligion = self.arrListOfUserData?.religion?.count ?? 0 - 1
                }
                self.lblReligion.attributedText = setAttributedText(text1 : "Religion   " ,text2 :(self.arrListOfUserData?.religion?[(userReligion ?? 0) ].value ?? ""),fontsize1 : FontSize.Size_12.rawValue,fontsize2 : FontSize.Size_12.rawValue,fontColor1 : .fontGrayColor3 , fontColor2 : .black, fontName1 : FontName.Regular.rawValue, fontName2 : FontName.Regular.rawValue)
                
                
                var demoData = [String]()
                var demoColor = [String]()
                for i in 0..<(self.arrMyIntrest.count) {
                    let str = self.arrListOfUserData?.interest?[self.arrMyIntrest[i] - 1].value
                    demoData.append(str ?? "")
                    let color = self.arrListOfUserData?.interest?[self.arrMyIntrest[i] - 1].colorID
                    demoColor.append(color ?? "")
                }
                self.arrImageData.removeAll()
                for i in 0..<(self.viewModel.userData?.data?.images?.count ?? 0){
                    if self.viewModel.userData?.data?.images?[i].image != "" {
                        self.arrImageData.append(self.viewModel.userData?.data?.images?[i].image ?? "")
                    }
                }
                self.collectionView.reloadData()
                
                self.intrestView.setData(data: demoData, color: demoColor)
                self.intrestView.lblTItle.text = ""
                self.intrestView.btnDwon.isHidden = true
                self.intrestView.collectionView.isScrollEnabled = false
                self.intrestView.layoutIfNeeded()
                self.intrestView.collectionView.reloadData()
                self.view.setNeedsLayout()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        likeView.setRoundedView()
        disLiekView.setRoundedView()
        likeView.setFullShadow()
        disLiekView.setFullShadow()
        
    }
    
    @IBAction func onTapLikeUserProfile(_ sender: Any) {
//        call API of User Like
    }
    @IBAction func onTapDisLikeUserProfiel(_ sender: Any) {
//        call API of User Like
    }
    
    
    func setUPUI(){
        
        lblIntrest.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        lblCommon.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        
        lblIntrest.text = "Interest"
        lblCommon.text = "6 in common"
        
        lblName.font = UIFont(name: FontName.SemiBold.rawValue, size:  FontSize.Size_24.rawValue)
        lblOccupation.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_12.rawValue))
        
        lblDistance.textColor = .buttonFontColor
        lblDistance.font = UIFont(name: FontName.Regular.rawValue, size: CustomFontSize(size: FontSize.Size_12.rawValue))
        
        lblBio.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        lblBio.textColor = .fontGrayColor2
        
        lblIntrest.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        
        lblCommon.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        lblCommon.textColor = .buttonFontColor
        
        lblInfo.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        
        lblSmoke.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        lblDrink.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
        lblReligion.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_12.rawValue)
    }
}



extension ViewProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
