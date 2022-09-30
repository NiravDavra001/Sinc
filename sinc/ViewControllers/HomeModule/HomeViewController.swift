//
//  HomeViewController.swift
//  sinc
//
//  Created by mac on 18/02/21.
//

import UIKit
import MapKit

class HomeViewController: UIViewController {
    
    var stackContainer : StackContainerView!
    var viewModelData = [CardsDataModel]()
    
    var tempCardData = [CardsDataModel]()
    
    var hintView = HintView()
    var viewModel = HomeViewModel()
    let locationManager = CLLocationManager()
    
    var totalCards = 0
    var totalRemainingCards = 0
    var totalPages = 0
    var curPageNo = 1
    
    var filterData : RegisterDetails?
    var isFirstTime = true
    
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterData = UserDefaultManager.share.getModelDataFromUserDefults(userData: RegisterDetails.self, key: .storeUserFilterData)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        configureStackController()
        setUpLocation()
        if !getBoolUserDefaultValue(key: .isUserFirstTime){
            self.tabBarController?.tabBar.isHidden = true
        }
    }
    
    func configureStackController(){
        stackContainer = StackContainerView()
        self.view.addSubview(stackContainer)
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        configureStackContainer()
        self.stackContainer.dataSource = self
        self.stackContainer.myDelegate = self
    }
    
    func setUpLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelData.removeAll()
        stackContainer.removeFromSuperview()
        configureStackController()
        getAllUserAPI()
    }
    
    func getAllUserAPI(){
        showActivityIndicator(uiView: self.view)
        viewModel.getAllUserList(pageNo: curPageNo, params: filterData ?? RegisterDetails(), completion: { [self] (isFinished,error) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.totalCards = self.viewModel.userProfile.profileID?.count ?? 0
                viewModelData.removeAll()
                if !tempCardData.isEmpty{
                    for item in tempCardData {
                        viewModelData.append(item)
                    }
                }
                tempCardData.removeAll()
                for item in 0..<self.totalCards {
                    self.viewModelData.append(CardsDataModel(cardImage: self.viewModel.userProfile.profileImage?[item], cardName: self.viewModel.userProfile.profileName?[item], cardId: self.viewModel.userProfile.profileID?[item], cardAge: self.viewModel.userProfile.profileAge?[item], cardOcuupation: self.viewModel.userProfile.profileOccupation?[item], cardDistance: self.viewModel.userProfile.profileDistance?[item]))
                }
                if isFirstTime{
                    isFirstTime = false
                    stackContainer.reloadData()
                }
                else{
                    stackContainer.removeFromSuperview()
                    configureStackController()
                    stackContainer.reloadData()
                }
                
                if !getBoolUserDefaultValue(key: .isUserFirstTime){
                    createSwipeHintLayer()
                }
            }
            else{
                self.showAlert(message: error)
            }
        })
    }
    
    func callLikeDisLikeSwipeAPI(isRightSwipe : Bool , likedUserID : Int){
        var dict = [String : Any]()
        dict.removeAll()
        dict["second_user_id"] = likedUserID
        
        if isRightSwipe {
            dict["type"] = 1
        }
        else{
            dict["type"] = 0
        }
        showActivityIndicator(uiView: self.view)
        viewModel.giveLikeDisLikeToUser(params: dict) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                print("captain got success")
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func configureStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 550/812).isActive = true
    }

    func createSwipeHintLayer(){
        
        hintView = HintView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(hintView)
        self.view.bringSubviewToFront(hintView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        hintView.addGestureRecognizer(tapGestureRecognizer)
      
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer){
        self.tabBarController?.tabBar.isHidden = false
        self.hintView.frame.size = .zero
        self.hintView.isHidden = true
        self.hintView.removeFromSuperview()
        setBoolUserDefaultValue(value: true, key: .isUserFirstTime)
    }
    
    @IBAction func onTapFilterTouchUpInside(_ sender: Any) {
        self.pushViewController(controllerID: .FiltersVC, storyBoardID: .Home)
    }
    
    
    
}

extension HomeViewController : MySwipeCardDelegate{
    func stopCardWhileAnimating() {
        
    }
    
    func checkCardIsRightSwipped() {
        
        totalRemainingCards = totalRemainingCards + 1
        if viewModelData.isEmpty == false{
            let cardID  = viewModelData.first?.cardId ?? 0
            self.callLikeDisLikeSwipeAPI(isRightSwipe: true, likedUserID: cardID)
            viewModelData.remove(at: 0)
        }
        if viewModelData.count == 2 {
            if curPageNo != viewModel.totalPages{
                curPageNo = curPageNo + 1
            }
            tempCardData.removeAll()
            tempCardData = viewModelData
            viewModelData.removeAll()
            getAllUserAPI()
        }
    }
    
    func checkCardIsLeftSwipped() {
        totalRemainingCards = totalRemainingCards + 1
        if viewModelData.isEmpty == false{
            let cardID  = viewModelData.first?.cardId ?? 0
            self.callLikeDisLikeSwipeAPI(isRightSwipe: false, likedUserID: cardID)
            viewModelData.remove(at: 0)
            stackContainer.isUserInteractionEnabled = true
        }
        if viewModelData.count == 2 {
            if curPageNo != viewModel.totalPages{
                curPageNo = curPageNo + 1
            }
            tempCardData.removeAll()
            tempCardData = viewModelData
            viewModelData.removeAll()
            getAllUserAPI()
        }
    }
    func onTapOpenUserProfile(userID: Int) {
        let vc = self.loadViewController(Storyboard: .Home, ViewController: .viewProfileVC) as! ViewProfileViewController
        vc.userID = userID
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
}

//viewProfileVC

extension HomeViewController : SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int {
        return viewModelData.count
    }
    func card(at index: Int) -> SwipeCardView {
        if index <= -1 {
            return SwipeCardView()
        }
        let card = SwipeCardView(data: viewModelData[index])
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
}
extension HomeViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            // you're good to go!
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("New location is \(location)")
            
            setDoubleUserDefaultValue(value: currentLatitued, key: .userLastLatitude)
            setDoubleUserDefaultValue(value: currentLongitued, key: .userLastLongitude)
            
            let oldLatitude = getDoubleUserDefaultValue(key: .userLastLatitude)
            let oldLongitude = getDoubleUserDefaultValue(key: .userLastLongitude)
            
            currentLatitued = location.coordinate.latitude
            currentLongitued = location.coordinate.longitude
            
            let distanceInMeters = location.distance(from: CLLocation(latitude: oldLatitude, longitude: oldLongitude))
            
            if distanceInMeters > updateLocationDistance {
                showActivityIndicator(uiView: self.view)
                self.viewModel.updateLocation { (isFinished, message) in
                    hideActivityIndicator(uiView: self.view)
                    if isFinished {
                    }
                    else{
                        self.showAlert(message: message)
                    }
                }
            }
            
        }
    }
}
