//
//  TagsColletionView.swift
//  sinc
//
//  Created by mac on 25/03/21.
//

import UIKit
import collection_view_layouts

class TagsColletionView: UIView {
    
    var layout: BaseLayout = TagsLayout()
    var tagsColor = [String]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDwon: UIButton!
    @IBOutlet weak var lblTItle: UILabel!
    @IBOutlet weak var constaintHeightAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var editView: UIView!
    var firstSectionItems = ["Happy hour", "Daytime fun", "Skiing", "Museums", "Art shows", "Vegan", "How-to Classes", "Drinking", "Hiking", "Dancing Classes"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
        setUpUI()
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
    func setUpUI(){
        collectionView.register(UINib(nibName: "IntrestsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IntrestsCollectionViewCell")
        
        btnEdit.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.delegate = self
        layout.cellsPadding = ItemsPadding(horizontal: 8, vertical: 8)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
        self.constaintHeightAnchor.constant = 50
        
        lblTItle.font = UIFont(name: FontName.Medium.rawValue, size: FontSize.Size_16.rawValue)
        lblTItle.textColor = .black
    }
    
    
    func setEditHiddenUnhidden(hidden : Bool){
        btnEdit.isHidden = hidden
        btnEdit.isEnabled = true
        btnEdit.isUserInteractionEnabled = true
    }
    
    func setName(txt : String){
        lblTItle.text = txt
    }
    
    func setData(data : [String] , color : [String]){
        firstSectionItems.removeAll()
        firstSectionItems = data
        tagsColor.removeAll()
        tagsColor = color
    }
    
    private func commonInit() {
        let bundle = Bundle.main
        let nib = UINib(nibName: "TagsColletionView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        view?.frame = self.bounds
        view?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view ?? UIView())
        
    }
    
    
    @IBAction func onTapEdit(_ sender: UIButton) {
        
    }
    @objc func onTapAddOrRemoveIntrests(){
        
    }
}

extension TagsColletionView : LayoutDelegate ,UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntrestsCollectionViewCell", for: indexPath) as? IntrestsCollectionViewCell
        if tagsColor.count != 0 {
            cell?.label.text = firstSectionItems[indexPath.row]
            cell?.contentView.backgroundColor = UIColor.init(hexaRGB: tagsColor[indexPath.row])
        }
        cell?.label.textColor  = .white
        self.collectionView.isScrollEnabled = false
        let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        self.constaintHeightAnchor.constant = height + 10
        self.setNeedsLayout()
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firstSectionItems.count
    }
    
    func cellSize(indexPath: IndexPath) -> CGSize {
        let height = UIScreen.main.bounds.height / 20
        let text = firstSectionItems[indexPath.row]
        let width = text.width(withConstrainedHeight: height, font: .systemFont(ofSize: 14)) + 40
        return CGSize(width: width, height: height)
    }
}
