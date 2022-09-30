//
//  InterestsViewController.swift
//  sinc
//
//  Created by mac on 06/02/21.
//

import UIKit
import collection_view_layouts

class InterestsViewController: UIViewController{
    
    var layout: BaseLayout = TagsLayout()
    let viewModel = InterestViewModel()
    var arrInterstData = [InterstsData]()
    var selectedItems = ""
    
    var window : UIWindow?
    
    @IBOutlet weak var bottomView : BottomNavPannel!
    @IBOutlet weak var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        layout.delegate = self
        layout.cellsPadding = ItemsPadding(horizontal: 8, vertical: 8)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
        
        bottomView.btnBack.addTarget(self, action: #selector(previousViewController), for: .touchUpInside)
        bottomView.btnNext.addTarget(self, action: #selector(onTapNext), for: .touchUpInside)
        
        collectionView.register(UINib(nibName: "IntrestsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IntrestsCollectionViewCell")
        
        getInstrestListAPI()
    }
    
    func getInstrestListAPI(){
        showActivityIndicator(uiView: self.view)
        viewModel.callGetInterestAPI { (isFinished,error) in
            if isFinished {
                let data = UserDefaultManager.share.getModelDataFromUserDefults(userData: GetInterstModel.self, key: .storeInterstModel)
                
                for item in 0..<(data?.data?.count ?? 0) {
                    self.arrInterstData.append(InterstsData(intrestId: -1, intrestName: "", intrestColor: "",isSelected: false))
                    self.arrInterstData[item].intrestId = data?.data?[item].id
                    self.arrInterstData[item].intrestName = data?.data?[item].name
                    self.arrInterstData[item].intrestColor = data?.data?[item].color
                }
                self.collectionView.reloadData()
            }
            else{
                self.showAlert(message: error)
            }
            hideActivityIndicator(uiView: self.view)
        }
    }
    
    @objc func previousViewController(){
        self.popViewController()
    }
    
    @objc func onTapNext(){
        let selectedData = arrInterstData.filter {($0.isSelected ?? false)}.map { $0.intrestId?.description ?? ""}
        let selectedTags = selectedData.joined(separator: ",")
        print(selectedTags)
        registerDetails.interest = selectedTags
        
        showActivityIndicator(uiView: self.view)
        viewModel.callUpdateInterstTagsAPI { (isFinished,error) in
            if isFinished{
                sceneDelegate?.setUpRootViewController()
            }
            else{
                self.showAlert(message: error)
            }
            hideActivityIndicator(uiView: self.view)
        }
    }
    
}
extension InterestsViewController:LayoutDelegate ,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrInterstData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntrestsCollectionViewCell", for: indexPath) as? IntrestsCollectionViewCell
        cell?.label.text = arrInterstData[indexPath.row].intrestName
        cell?.label.textColor = .black
        if arrInterstData[indexPath.row].isSelected == true {
            cell?.contentView.backgroundColor = UIColor.init(hexaRGB: arrInterstData[indexPath.row].intrestColor ?? "")
            cell?.label.textColor = .white
        }
        else{
            cell?.contentView.backgroundColor = .white
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        let height = UIScreen.main.bounds.height / 20
        let text = arrInterstData[indexPath.row].intrestName
        let width = (text?.width(withConstrainedHeight: height, font: UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_14.rawValue)!) ?? 0) + 40
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntrestsCollectionViewCell", for: indexPath) as? IntrestsCollectionViewCell
        
        if arrInterstData[indexPath.row].isSelected == true{
            arrInterstData[indexPath.row].isSelected = false
            cell?.contentView.backgroundColor = .white
            collectionView.reloadItems(at: [indexPath])
        }
        else{
            arrInterstData[indexPath.row].isSelected = true
            cell?.contentView.backgroundColor = UIColor.init(hexaRGB: arrInterstData[indexPath.row].intrestColor ?? "")
            collectionView.reloadItems(at: [indexPath])
        }   
    }
}
