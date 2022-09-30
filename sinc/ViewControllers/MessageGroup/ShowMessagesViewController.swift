//
//  ShowMessagesViewController.swift
//  sinc
//
//  Created by mac on 30/04/21.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import IQKeyboardManagerSwift
import SocketIO
import SDWebImage
import Moya

struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

struct Messages: MessageType{
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
}

class ShowMessagesViewController: MessagesViewController, MessagesLayoutDelegate , UITextViewDelegate {
    
//MARK: Variables
    
    var getUserDetails : UpdateProfileModel?
    var senderUser = Sender(senderId: "self", displayName: "iOS")
    var receiverUser = Sender(senderId: "other", displayName: "Pavan")
    var messages = [Messages]()
    var receiverUserDetails: SenderUser?
    
    let refreshControl = UIRefreshControl()
    var senderUserImage = UIImage()
    var receiverUserImage = UIImage(){
        didSet{
            messagesCollectionView.reloadData()
        }
    }
    
    let viewModel = ChatViewModel()
    
    var myUserID : Int?
    var anotherUserID : Int?
    
    var socket = SocketConnection.shared.socket
    
    var isBlocked = false{
        didSet{
            print("Is Blocked: \(isBlocked)")
        }
    }
    
    var currentPage = 0
    var totalPage = 0
    var conversationID : Int?
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        messagesCollectionView.scrollToLastItem()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationController()
        self.navigationController?.navigationBar.isHidden = false
        
        getUserDetails = UserDefaultManager.share.getModelDataFromUserDefults(userData: UpdateProfileModel.self, key: .storeUpdateProfileModel)
        
        messageInputBar.delegate = self
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        self.socket.on("sendMessage") { dataArray, ack in
            if dataArray.count > 0{
                if let tempDic = dataArray[0] as? [String: Any]{
                    print("dictionary",tempDic)
                    let senderID = tempDic["sender_id"] as? Int
                    let dateInString = tempDic["created_at"] as? String
                    let message = tempDic["message"] as? String
                    let msgID = tempDic["id"] as? Int
                    let createdDate = dateInString?.getDate()
                    var messages = Messages(sender: self.senderUser,
                                            messageId: "\(msgID ?? 0)",
                                            sentDate: createdDate ?? Date(),
                                            kind: .text(message ?? ""))
                    if senderID == self.myUserID{
                        messages.sender = self.senderUser
                    }else if senderID == self.anotherUserID{
                        messages.sender = self.receiverUser
                    }else{
                        return
                    }
                    self.insertMessage(messages)
                    self.messagesCollectionView.reloadData()
                }
            }
        }
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        scrollsToLastItemOnKeyboardBeginsEditing = true
        maintainPositionOnKeyboardFrameChanged = true
        loadFirstMessages()
        messagesCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadMoreMessages), for: .valueChanged)
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
        }
        
//        configureMessageInputBar()
    }
    
    func setUpNavigationController(){
        self.title = "Diane"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.9, height: 38))
        
        let userImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        userImage.setRoundedView()
        userImage.frame.origin = newView.frame.origin
        userImage.image = UIImage(named: "demo_profile")
        newView.addSubview(userImage)
        let lblTitles = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 38))
        
        lblTitles.center = userImage.center
        lblTitles.frame.origin.x = userImage.frame.width + 5
        lblTitles.text = receiverUser.displayName
        newView.addSubview(lblTitles)
        self.navigationItem.titleView = newView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        NavigationBarDesign()
        ConfigureUsers()
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.socket.on(clientEvent: .error) {data, ack in
            print("socket error : ",data)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
    @objc func bellTapped(_ sender: UIBarButtonItem){
        self.showAlert(message: "Development is in progress.")
    }

    func NavigationBarDesign(){
        let searchButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 30.0, height: 30.0))
        searchButton.setImage(UIImage(systemName: "ellipsis") ?? UIImage(), for: .normal)
        searchButton.addTarget(self, action: #selector(menuTapped(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: searchButton)]
        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        setUpNavBarBackButton(viewController: self, color: UIColor.blue)
    }
    
    func ConfigureUsers(){
        //Sender
        senderUser.senderId = "\(myUserID ?? 0)"
        let name = self.getUserDetails?.data?.name
        senderUser.displayName = (name == "" ? "Anonymous" : name) ?? "capo"
        
        if let receiverUserDetails = receiverUserDetails{
            receiverUser.senderId = "\(anotherUserID ?? 0)"
            receiverUser.displayName = "Awesome"
        }
    }
    
    override func viewDidLayoutSubviews() {
        configureMessageInputBar()
    }
    
    func configureMessageInputBar() {
        messageInputBar.delegate = self
        messageInputBar.inputTextView.backgroundColor = .textViewBGColor
        messageInputBar.inputTextView.setRoundedView()
        messageInputBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: messageInputBar.frame.height)
        
        messageInputBar.sendButton.frame = CGRect(x: 0, y: 0, width: 48, height: 48)
        messageInputBar.sendButton.setSize(CGSize(width: 48, height: 48), animated: false)
        
        messageInputBar.sendButton.setTitle("", for: .normal)
        messageInputBar.sendButton.setImage(UIImage(named: "send_icon"), for: .normal)
        messageInputBar.sendButton.setBackgroundImage(UIImage(named: "select_button"), for: .normal)
        messageInputBar.sendButton.setRoundedView()
    }
    
    func insertMessage(_ message: Messages) {
        if messages.contains(where: { (msg) in
            return msg.messageId == message.messageId
        }){
            print("repeated msg..")
            return
        }
        
        if currentPage != 1{
            messages.insert(message, at: 0)
        }else{
            
            messages.append(message)
        }
        
        messagesCollectionView.performBatchUpdates({
            messagesCollectionView.insertSections([messages.count - 1])
            if messages.count >= 2 {
                messagesCollectionView.reloadSections([messages.count - 2])
            }
        }, completion: { [weak self] _ in
            if self?.isLastSectionVisible() == true {
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        })
    }
    
    func loadFirstMessages() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.getOlderMessages(pageNumber: self.currentPage + 1) { messages in
                if messages != nil{
                    self.messages = messages!
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToLastItem()
                }else{
                    self.messagesCollectionView.scrollToLastItem()
                }
            }
        }
    }
    
    @objc func loadMoreMessages() {
        print("Load More message")
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 1) {
            if self.currentPage + 1 <= self.totalPage{
                self.getOlderMessages(pageNumber: self.currentPage + 1) { messages in
                    if messages != nil{
                        self.messages.insert(contentsOf: messages!, at: 0)
                        self.messagesCollectionView.reloadDataAndKeepOffset()
                        self.refreshControl.endRefreshing()
                    }else{
                      self.refreshControl.endRefreshing()
                    }
                }
            }else{
              DispatchQueue.main.async {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    func isLastSectionVisible() -> Bool {
        guard !messages.isEmpty else { return false }
        let lastIndexPath = IndexPath(item: 0, section: messages.count - 1)
        return messagesCollectionView.indexPathsForVisibleItems.contains(lastIndexPath)
    }
    
    func getOlderMessages(pageNumber: Int ,completion:@escaping ([Messages]?) -> ())  {
        viewModel.callGetUserChat(conversationID: conversationID ?? 0, pageNumber: pageNumber) { (isFinished, message) in
            if isFinished {
                var messages = [Messages]()
                let chatArray = self.viewModel.chatDetails?.data?.data?.reversed()
                self.currentPage = self.viewModel.chatDetails?.data?.currentPage ?? 0
                self.totalPage = self.viewModel.chatDetails?.data?.lastPage ?? 0
                
                for item in chatArray! {
                    var message = Messages(sender: self.senderUser,
                                           messageId: "\(item.senderId ?? 0)",
                                           sentDate: item.createdAt?.getDate() ?? Date(),
                                           kind: .text(item.message ?? ""))
                    if item.senderId == Int(self.senderUser.senderId){
                         message.sender = self.senderUser
                    }else{
                        message.sender = self.receiverUser
                    }
                    messages.append(message)
                }
                
                completion(messages)
            }
            else{
                self.showAlert(message: message)
            }
        }
    }
    
    func BlockAndUnBlockUser(userID: Int,status: Int,completion:@escaping(Bool) -> Void){
//        ShowLoaderOnView()
//        provider.request(.requestForChat(requestID: userID, status: status)) {[weak self] Result in
////            HideLoaderOnView()
//            switch Result{
//            case .success(let response):
//                do {
//                    let json = try JSONDecoder().decode(SuccessMessageModel.self, from: response.data)
//                    if json.success ?? false{
//                        completion(true)
//                    }else{
//                        completion(false)
////                        displayAlertWithMessage(json.message ?? AlertMessages.somethingWentWrong)
//                    }
//                } catch {
//                    completion(false)
////                    displayAlertWithMessage(error.localizedDescription)
//                }
//            case .failure( _):
//                completion(false)
////                displayAlertWithMessage(error.localizedDescription)
//            }
//        }
    }
    
    func ShowAlertForBlockAndUnBlockUser(completion:@escaping (Bool) -> ()){
//        let currentUserId = getUserDetails?.data?.id
//        guard let conversationStatus = conversationStatus else {
//            print("ConversationStatus: Null")
//            return
//        }
//         print("ConversationStatus: \(conversationStatus)")
//        var statusString = ""
//        statusString = conversationStatus.isBlocked(id: conversationStatus.getOtherUser(currentUser: currentUserId)) ? "LocalizedStringKeys.Unblock.localized()" : "LocalizedStringKeys.Block.localized()"
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: statusString, style: .destructive, handler: { ACTION in
//            // print("UserID: \(conversationStatus.getOtherUser(currentUser: currentUserId))")
//            // print("Status: \(conversationStatus.isBlocked(id: conversationStatus.getOtherUser(currentUser: currentUserId)))")
//            self.BlockAndUnBlockUser(userID: conversationStatus.getOtherUser(currentUser: currentUserId), status:conversationStatus.isBlocked(id: conversationStatus.getOtherUser(currentUser: currentUserId)) ? 1 : 3) { isSuccess in
//                if isSuccess{
//                    if self.receiverUserDetails?.id ?? 0 == self.conversationStatus?.receiverID ?? 0{
//                        self.conversationStatus?.isReceiverBlock = self.conversationStatus?.isReceiverBlock == 0 ? 1 : 0
//                    }else{
//                        self.conversationStatus?.isSenderBlock = self.conversationStatus?.isSenderBlock == 0 ? 1 : 0
//                    }
//                    completion(true)
//                }else{
//                    completion(false)
//                }
//            }
//        }))
//        alert.addAction(UIAlertAction(title: LocalizedStringKeys.Cancel.localized(), style: .cancel, handler: {
//            ACTION in
//            completion(false)
//        }))
//        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    
    @objc func menuTapped(_ sender: UIBarButtonItem){
        self.ShowAlertForBlockAndUnBlockUser { _ in
            print("Done")
        }
    }
}

extension ShowMessagesViewController: MessagesDataSource, MessagesDisplayDelegate{
    //MessagesDataSource
    func currentSender() -> SenderType {
        return senderUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    //MessagesDisplayDelegate
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        if message.sender.senderId == senderUser.senderId{
            return UIColor.appDarkGreen
        }else{
            return UIColor.borderColor
        }
    }
    
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.image = UIImage(named: "demoProfile")
    }
    
    
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return [.url, .address, .phoneNumber, .date, .transitInformation, .mention, .hashtag]
    }
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .custom { view in
            let radius: CGFloat = 5
            let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            view.layer.mask = mask
        }
    }
}

extension ShowMessagesViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        messageInputBar.inputTextView.text = String()
        messageInputBar.invalidatePlugins()
        // Send button activity animation
        messageInputBar.sendButton.startAnimating()
        messageInputBar.inputTextView.placeholder = "Sending..."
        DispatchQueue.global(qos: .default).async {
            DispatchQueue.main.async { [weak self] in
                let dic = ["sender_id": self?.myUserID ?? 0,
                           "receiver_id": self?.anotherUserID ?? 0,
                           "message": text.trimmingCharacters(in: .whitespacesAndNewlines)] as [String : Any]
                
                self?.socket.emit("sendMessage", with: [dic]) {
                    print("Message Sent")
                }
                self?.messageInputBar.sendButton.stopAnimating()
                self?.messageInputBar.inputTextView.placeholder = "Type a message..."
                self?.messagesCollectionView.scrollToLastItem(animated: true)
            }
        }
    }
}

open class SocketConnection {
    
    public static let shared = SocketConnection()
    public let manager: SocketManager
    public var socket: SocketIOClient
    
    private init() {
        manager = SocketManager(socketURL: URL(string: "http://13.235.125.148:3000")!, config: [.log(true),.reconnects(true)])
        socket = manager.defaultSocket
        socket.connect()
    }
}

