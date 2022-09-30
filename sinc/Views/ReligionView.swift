//
//  ReligionView.swift
//  sinc
//
//  Created by mac on 05/02/21.
//

import UIKit
struct choiceModel {
    var title : String?
    var isSelected : Bool?
    var id : Int?
}

protocol ReligionCollectionViewDelegate {
    func reloadCollectionView(curCellIndex : Int ,sender : UICollectionView)
}

class ReligionView: UIView {
    
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var topAncher: NSLayoutConstraint!
    
    var previosIndex = -1
    var delegate : ReligionCollectionViewDelegate?
    var arrReligion = [choiceModel]()
    
    var cellType : profileDetails?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        titleLabel.font = UIFont(name: FontName.Medium.rawValue, size: CustomFontSize(size: FontSize.Size_16.rawValue))
//        topAncher.constant = setHeightAsPerDeviceHeight(getHeight: topAncher.constant)
    }
    
    func setArrayItem(title : String, profileType : profileDetails){
        titleLabel.text = title
        let data = UserDefaultManager.share.getModelDataFromUserDefults(userData: UserServerInfo.self, key: .storeUserPersonalInfo)
        
        if profileType == profileDetails.pets{
            for item in 0..<(data?.isPets?.count ?? 0) {
                arrReligion.append(choiceModel(title: (data?.isPets?[item].value ?? ""), isSelected: false, id: (data?.isPets?[item].id ?? 0)))
            }
            
        }
        if profileType == profileDetails.smoking{
            arrReligion = [choiceModel(title: "Regularly", isSelected: false, id: 1),
                           choiceModel(title: "Occasionally", isSelected: false, id: 2),
                           choiceModel(title: "Does not smoke", isSelected: false, id: 3)]
        }
        if profileType == profileDetails.drinking{
            arrReligion = [choiceModel(title: "Regularly", isSelected: false, id: 1),
                           choiceModel(title: "Occasionally", isSelected: false, id: 2),
                           choiceModel(title: "Does not drink", isSelected: false, id: 3)]
        }
        if profileType == profileDetails.religion{
            for item in 0..<(data?.religion?.count ?? 0) {
                arrReligion.append(choiceModel(title: (data?.religion?[item].value ?? ""), isSelected: false, id: (data?.religion?[item].id ?? 0)))
            }
        }
        if profileType == profileDetails.education{
            for item in 0..<(data?.education?.count ?? 0) {
                arrReligion.append(choiceModel(title: (data?.education?[item].value ?? ""), isSelected: false, id: (data?.education?[item].id ?? 0)))
            }
        }
        if profileType == profileDetails.sexual {
            for item in 0..<(data?.sexualOrientation?.count ?? 0) {
                arrReligion.append(choiceModel(title: (data?.sexualOrientation?[item].value ?? ""), isSelected: false, id: (data?.sexualOrientation?[item].id ?? 0)))
            }
        }
        if profileType == profileDetails.wantGender {
            arrReligion = [choiceModel(title: "Woman", isSelected: false, id: 1),choiceModel(title: "Men", isSelected: false, id: 2),choiceModel(title: "All", isSelected: false, id: 3)]
        }
        if profileType == profileDetails.relationShipStatus {
            for item in 0..<(data?.lookingFor?.count ?? 0) {
                arrReligion.append(choiceModel(title: (data?.lookingFor?[item].value ?? ""), isSelected: false, id: (data?.lookingFor?[item].id ?? 0)))
            }
        }
    }
    
    func setUpUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ReligionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReligionCollectionViewCell")
    }
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "ReligionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
        setUpUI()
    }
    
    func checkIsSelectedOrNot() -> String{
        var str = String()
        str = ""
        for item in 0..<arrReligion.count {
            if arrReligion[item].isSelected == true{
                if str == "" {
                    str = "\((arrReligion[item].id ?? 0) + 1)"
                }
                else{
                    str = str + "," + "\((arrReligion[item].id ?? 0) + 1)"
                }
                printLog(string: "collection view : ", data: str)
            }
        }
        return str
    }
    
}

extension ReligionView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrReligion.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReligionCollectionViewCell", for: indexPath) as! ReligionCollectionViewCell
        cell.label.text = arrReligion[indexPath.row].title
        cell.unselectCurItem()
        cell.label.textColor = .black
        
        if arrReligion[indexPath.row].isSelected == true {
            cell.selectCurItem()
            cell.label.textColor = .white
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let text = arrReligion[indexPath.row].title
        let width = (text?.width(withConstrainedHeight: height, font: UIFont(name: FontName.Regular.rawValue, size: FontSize.Size_14.rawValue)!) ?? 0) + 40
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cellType != profileDetails.pets {
            var curIndex = Int()
            for item in 0..<arrReligion.count {
                if item == indexPath.row {
                    arrReligion[item].id = indexPath.row
                    curIndex = indexPath.row
                    arrReligion[item].isSelected = true
                }
                else{
                    arrReligion[item].isSelected = false
                }
            }
            self.delegate?.reloadCollectionView(curCellIndex: curIndex, sender: collectionView)
        }
        else{
            var curIndex = Int()
            for item in 0..<arrReligion.count {
                if item == indexPath.row && arrReligion[indexPath.row].isSelected == true{
                    arrReligion[item].isSelected = false
                }
                else if item == indexPath.row {
                    arrReligion[item].id = indexPath.row
                    curIndex = indexPath.row
                    arrReligion[item].isSelected = true
                }
            }
            self.delegate?.reloadCollectionView(curCellIndex: curIndex, sender: collectionView)
        }
    }
}

