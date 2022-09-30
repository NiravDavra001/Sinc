//
//  editProfileCollectionViewCell.swift
//  SincDemo
//
//  Created by pc on 10/02/21.
//  Copyright © 2021 pc. All rights reserved.
//

import UIKit

protocol EditProfileCollectionViewCellDelegate {
    func onTapRemoveImageData(index : Int)
}

class editProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btnRemoveImage: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var index : Int?
    var delegate : EditProfileCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.image = UIImage(named: "Add_Image")
        btnRemoveImage.isHidden = true
        btnRemoveImage.addTarget(self, action: #selector(onTapRemoveImage), for: .touchUpInside)
    }
    
    override func draw(_ rect: CGRect) {
//        self.contentView.backgroundColor = .yellow
        self.imageView.setUpCornerRadius(8)
    }
    
    @objc func onTapRemoveImage(){
        btnRemoveImage.isHidden = true
        delegate?.onTapRemoveImageData(index: index ?? 0)
        imageView.image = UIImage(named: "Add_Image")
    }
    
    func setUpImage(imageName : String?){
        
    }
    func setImageWithURL(url : String){
//        sd_imageURL
        let url = URL(string: url)
        imageView.sd_setImage(with: url, completed: nil) //= URL(string: url)
        btnRemoveImage.isHidden = false
    }

}
