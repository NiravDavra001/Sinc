//
//  SelectInstrestsViewController.swift
//  SincDemo
//
//  Created by pc on 10/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit
import collection_view_layouts

class SelectInstrestsViewController: UIViewController {
    
    var layout: BaseLayout = TagsLayout()
    @IBOutlet weak var collectionView : UICollectionView!
    
    var arrInterstData = [InterstsData]()
    var alreadySelectedInterst = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)?.interest
        
        for i in 0..<(data?.count ?? 0) {
            arrInterstData.append(InterstsData(intrestId: data?[i].id, intrestName: data?[i].value, intrestColor: data?[i].colorID, isSelected: false))
            for j in 0..<(alreadySelectedInterst.count) {
                if data?[i].id == alreadySelectedInterst[j]{
                    arrInterstData[i].isSelected = true
                }
            }
        }
        
        collectionView.register(UINib(nibName: "IntrestsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IntrestsCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.delegate = self
        layout.cellsPadding = ItemsPadding(horizontal: 8, vertical: 8)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let selectedData = arrInterstData.filter {($0.isSelected ?? false)}.map { $0.intrestId?.description ?? ""}
        let selectedTags = selectedData.joined(separator: ",")
        print(selectedTags)
        registerDetails.interest = selectedTags
    }
}

extension SelectInstrestsViewController :LayoutDelegate, UICollectionViewDelegate , UICollectionViewDataSource {
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
        let width = (text?.width(withConstrainedHeight: height, font: .systemFont(ofSize: 14)) ?? 0) + 40
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
