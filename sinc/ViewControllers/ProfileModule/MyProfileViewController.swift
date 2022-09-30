//
//  MyProfileViewController.swift
//  sinc
//
//  Created by mac on 23/03/21.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblUserAgeName: UILabel!
    @IBOutlet weak var lblUserOccupation: UILabel!
    @IBOutlet weak var btnPremium: UIButton!
    
    @IBOutlet weak var editPrifoleView: UIView!
    @IBOutlet weak var lblViewEditProfile: UILabel!
    @IBOutlet weak var lblLikeMe: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var lblLikeCount: UILabel!
    
    @IBOutlet weak var viewProfileSepraterView: UIView!
    @IBOutlet weak var likeSepraterView: UIView!
    
    @IBOutlet weak var viewLikeMe: UIView!
    let viewModel = ViewMyProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MyProfileCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyProfileCollectionViewCell")
        collectionView.isPagingEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editProfileClick))
        editPrifoleView.addGestureRecognizer(tapGesture)
        
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(likeMeClick))
        viewLikeMe.addGestureRecognizer(likeTapGesture)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.collectionViewLayout = layout
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyProfileAPI()
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        setUpUI()
    }
    
    @objc func editProfileClick(){
        self.pushViewController(controllerID: .ViewMyProfileVC, storyBoardID: .Profile)
    }
    @objc func likeMeClick(){
        self.showAlert(message: "Development In Progress")
    }
    
    func setUpUI(){
        pageController.numberOfPages = 4
        pageController.currentPageIndicatorTintColor = .tagViewRedColor
        
        imgProfile.setRoundedView()
        
        lblLikeCount.setRoundedView()
        lblLikeCount.textColor = .white
        likeView.setRoundedView()
        likeView.setUpButtonGradiantColor(leftColor: .appDarkGreen, rightColor: .appLightGreen)
        
        lblUserAgeName.font = UIFont(name: FontName.SemiBold.rawValue, size: FontSize.Size_24.rawValue)
        lblUserAgeName.textColor = .white
        lblUserOccupation.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_14.rawValue)
        lblUserOccupation.textColor = .white
        
        btnPremium.setRoundedView()
        btnPremium.backgroundColor = .btnbackgroundPink
        btnPremium.setTitleColor(.white, for: .normal)
        btnPremium.setTitle("Go to Premium", for: .normal)
        btnPremium.titleLabel?.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        
        lblViewEditProfile.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        lblViewEditProfile.textColor = .fontGrayColor2
        
        lblViewEditProfile.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        lblViewEditProfile.textColor = .fontGrayColor2
        
        lblLikeMe.font = UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_16.rawValue)
        lblLikeMe.textColor = .fontGrayColor2
        
        viewProfileSepraterView.backgroundColor =  .sepraterViewColor
        likeSepraterView.backgroundColor =  .sepraterViewColor
    }
    
    func getMyProfileAPI(){
        showActivityIndicator(uiView: self.view)
        viewModel.callGetMyProfileDetailsAPI { [self] (isFinished, error) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                imgProfile.sd_setImage(with: URL(string: (viewModel.myProfile?.data?.image?.first?.image ?? "")), completed: nil)
                lblUserAgeName.text = (viewModel.myProfile?.data?.name ?? "") + "," + (viewModel.myProfile?.data?.age ?? "")
                lblUserOccupation.text = viewModel.myProfile?.data?.profession
            }
            else{
                self.showAlert(message: error)
            }
        }
    }
    
    @IBAction func onTapGoPremium(_ sender: Any) {
        self.presentViewController(controllerID: .PremiumFeaturesPopupVC, storyBoardID: .Setting)
    }
    
}

extension MyProfileViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyProfileCollectionViewCell", for: indexPath) as? MyProfileCollectionViewCell
        pageController.currentPage = indexPath.row
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.bounds.width, height : self.collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageController.currentPage = visibleIndexPath.row
        }
    }
}
