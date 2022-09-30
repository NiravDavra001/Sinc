//
//  ChatMessagesViewController.swift
//  sinc
//
//  Created by mac on 12/03/21.
//

import UIKit
import Foundation
import SocketIO
import Moya

struct UserChatListDetails {
    var userName : [String]?
    var userImage : [String]?
    var userLastMessage : [String]?
    var userID : [Int]?
    
}

class ChatMessagesViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblScreenName: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    
    let viewModel = ChatListViewModel()
//    let provider = MoyaProvider<API>()
    var userChatDetails : UserChatListDetails?
        
    var userName : [String]?
    var userImage : [String]?
    var userTime : [String]?
    var userLastMessage : [String]?
    
    var anotherUserID : Int?
    var currentUserID : Int?
    var conversationID : Int?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.removeObserver(self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MessageTopTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageTopTableViewCell")
        tableView.register(UINib(nibName: "MessageBottomTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageBottomTableViewCell")
        
        setUpUi()
        callAPIOfLikedMe()
    }
    
    func setUpUi(){
        self.navigationController?.navigationBar.topItem?.title = "Message"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationItem.title = "Messages"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func callAPIOfLikedMe(){
        showActivityIndicator(uiView: self.view)
        viewModel.getLikeME { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                self.callAPIofNewMatches()
            }
            else{
                self.callAPIofNewMatches()
            }
        }
    }
    
    func callAPIofNewMatches(){
        showActivityIndicator(uiView: self.view)
        viewModel.getNewMatches { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .none)
                self.callUserListAPI()
            }
            else{
                self.callUserListAPI()
            }
        }
    }
    
    func callUserListAPI(){
        showActivityIndicator(uiView: self.view)
        viewModel.callGetUserListForChat { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                self.userName?.removeAll()
                let name = self.viewModel.chatDetails?.data?.data?.map{$0.senderUser?.name ?? ""}
                let image = self.viewModel.chatDetails?.data?.data?.map{$0.senderUser?.image ?? ""}
                self.currentUserID = self.viewModel.chatDetails?.data?.currentUser?.id ?? 0
                self.anotherUserID = self.viewModel.chatDetails?.data?.data?.first?.senderUser?.id ?? 0
                self.conversationID = self.viewModel.chatDetails?.data?.data?.first?.conversationId ?? 0
//                let userIDS = self.viewModel.chatDetails?.data?.map{ $0.secondUserId ?? 0}
                
                self.userChatDetails = UserChatListDetails(userName: name, userImage: image, userLastMessage: [""], userID: [0])
//                setIntegerUserDefaultValue(value: self.viewModel.chatDetails?.data?.first?.userId ?? 0, key: .userID)
//                let lastMessage = self.viewModel.chatDetails?.data?.map{ $0.image}
//                self.userName = name as? [String]
                
                self.tableView.reloadData()
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func callAPIofGetConeversationID(params : [String : Any]){
        showActivityIndicator(uiView: self.view)
        viewModel.getConversationID(params: params) { (isFinished, message) in
            hideActivityIndicator(uiView: self.view)
            if isFinished {
                
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
}

extension ChatMessagesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else if section == 1{
            return 1
        }
        else{
            return (userChatDetails?.userName?.count ?? 0)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 || indexPath.section == 1{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "MessageTopTableViewCell") as? MessageTopTableViewCell
            cell?.delegate = self
            if indexPath.section == 0 {
                cell?.type = MessageCellType.likedMe
                cell?.selectionStyle = .none
                cell?.likedMeImage = self.viewModel.likedMeList?.data?.map{$0.image} as? [String]
                cell?.reloadCollectionView()
            }
            else{
                cell?.type = MessageCellType.newMatches
                let images = self.viewModel.newMatchesList?.data?.map{$0.image ?? ""}
                cell?.newMatchesImage = images
                cell?.selectionStyle = .none
                cell?.reloadCollectionView()
            }
            return cell ?? UITableViewCell()
        }
        else{
            let cell  = tableView.dequeueReusableCell(withIdentifier: "MessageBottomTableViewCell") as? MessageBottomTableViewCell
            cell?.lblUserName.text = userChatDetails?.userName?[indexPath.row]
            cell?.imageUserProfile?.sd_setImage(with: URL(string: userChatDetails?.userImage?[indexPath.row] ?? ""), completed: nil)
            cell?.selectionStyle = .none
            cell?.lblTime.text = ""
            cell?.lblStatus.text = ""
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84 * UIScreen.main.bounds.height / 812
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Liked Me"
        }
        else if section == 1 {
            return "new Matches"
        }
        else {
            return "\(userChatDetails?.userName?.count ?? 0) Friends"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let vc = self.loadViewController(Storyboard: .Message, ViewController: .ShowMessagesVC) as! ShowMessagesViewController
            
            let id = getIntegerUserDefaultValue(key: .userID)
            anotherUserID = 1
            vc.conversationID = 2
            vc.myUserID = id
            vc.anotherUserID = self.anotherUserID
            vc.receiverUserDetails = self.viewModel.chatDetails?.data?.data?.first?.senderUser
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
}
extension ChatMessagesViewController : MessageTopTableViewCellDelegate {
    func onTapOpenUserProfile(userID: Int, type: MessageCellType) {
        var ID : Int?
        if type == MessageCellType.likedMe {
            ID = self.viewModel.likedMeList?.data?[userID].userId
        }
        else {
            ID = self.viewModel.newMatchesList?.data?[userID].id
        }
        
        let vc = self.loadViewController(Storyboard: .Home, ViewController: .viewProfileVC) as! ViewProfileViewController
        vc.userID = ID
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
extension ChatMessagesViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

