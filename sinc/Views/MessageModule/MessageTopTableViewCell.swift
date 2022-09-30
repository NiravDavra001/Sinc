//
//  MessageTopTableViewCell.swift
//  sinc
//
//  Created by mac on 12/03/21.
//

import UIKit

protocol MessageTopTableViewCellDelegate {
    func onTapOpenUserProfile(userID : Int , type : MessageCellType)
}

enum MessageCellType : String {
    case likedMe = "like"
    case newMatches = "new"
}

class MessageTopTableViewCell: UITableViewCell {
    
    var likedMeImage : [String]?
    var newMatchesImage : [String]?
    var delegate : MessageTopTableViewCellDelegate?
    var type : MessageCellType?

    @IBOutlet weak var CollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CollectionView.delegate = self
        CollectionView.dataSource = self
        
        CollectionView.register(UINib(nibName: "MessageTopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MessageTopCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func reloadCollectionView(){
        self.CollectionView.reloadData()
    }
    
}
extension MessageTopTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == MessageCellType.likedMe {
            return likedMeImage?.count ?? 0
        }
        else{
            return newMatchesImage?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "MessageTopCollectionViewCell", for: indexPath) as? MessageTopCollectionViewCell
        cell?.imageView.contentMode = .scaleToFill
        if type == MessageCellType.likedMe {
            cell?.imageView.sd_setImage(with: URL(string: self.likedMeImage?[indexPath.row] ?? ""), completed: nil)
        }
        else{
            cell?.imageView.sd_setImage(with: URL(string: self.newMatchesImage?[indexPath.row] ?? ""), completed: nil)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.onTapOpenUserProfile(userID: indexPath.row, type: type ?? MessageCellType.likedMe)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56 * UIScreen.main.bounds.width / 375, height: 56 * UIScreen.main.bounds.width / 375)
    }
    
}

