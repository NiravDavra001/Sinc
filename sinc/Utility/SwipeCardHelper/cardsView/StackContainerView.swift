//
//  StackContainerController.swift

//

import UIKit


class StackContainerView: UIView, SwipeCardsDelegate {
    func stopCardWhileAnimating() {
        
    }
    
    
    

    //MARK: - Properties

    var numberOfCardsToShow: Int = 0
    var cardsToBeVisible: Int = 2
    var cardViews : [SwipeCardView] = []
    var remainingcards: Int = 0
    var isSwipeDirectionIsRight = false
    let horizontalInset: CGFloat = 0.0
    let verticalInset: CGFloat = 14.0
    
    var rotationOffset = Float.pi / 360
    
    var curCardNo = 0
    var isFirstTime = false
    
    var visibleCards: [SwipeCardView] {
        return subviews as? [SwipeCardView] ?? []
    }
    var dataSource: SwipeCardsDataSource? 
    
    var cardCenters = CGPoint.zero
    
    var totalNumberOfCards = 0
    var myDelegate: MySwipeCardDelegate?
    
    var mainView = UIView()
    
    
    var closeButton = UIButton()
    var doneButton = UIButton()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        configureOtherItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUPUI(){
        printLog(string : "in main view")
        
    }
///   Cretae All Other Ui Here
    func configureOtherItems(){
        //        184  60
        let stackView = UIStackView()
        self.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 60 / 536).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 184 / 375).isActive = true
        
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        closeButton = UIButton()
        stackView.addArrangedSubview(closeButton)
        closeButton.backgroundColor  = .white
        closeButton.setImage(UIImage(named: "closeSwipe"), for: .normal)
        
        
        let viewBlank = UIView()
        stackView.addArrangedSubview(viewBlank)
        
        doneButton = UIButton()
        stackView.addArrangedSubview(doneButton)
        doneButton.backgroundColor  = .white
        doneButton.setImage(UIImage(named: "doneSwipe"), for: .normal)
        
        closeButton.widthAnchor.constraint(equalTo: doneButton.widthAnchor, multiplier: 1).isActive = true
        closeButton.heightAnchor.constraint(equalTo: doneButton.widthAnchor, multiplier: 1).isActive = true
        
        
    }
    override func draw(_ rect: CGRect) {
        closeButton.layer.cornerRadius = min(closeButton.bounds.width / 2,closeButton.bounds.height / 2)
        closeButton.clipsToBounds = true
        
        closeButton.layer.shadowOpacity = 1
        closeButton.layer.shadowRadius = 8
        closeButton.layer.masksToBounds = false
        closeButton.layer.shouldRasterize = true
        closeButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        closeButton.addTarget(self, action: #selector(onClickCloseBtnTouchUpInside), for: .touchUpInside)
        
        doneButton.layer.cornerRadius = min(doneButton.bounds.width / 2,doneButton.bounds.height / 2)
        doneButton.clipsToBounds = true
        
        doneButton.layer.shadowOpacity = 1
        doneButton.layer.shadowRadius = 8
        doneButton.layer.masksToBounds = false
        doneButton.layer.shouldRasterize = true
        doneButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        doneButton.addTarget(self, action: #selector(onClickDoneBtnTouchUpInside), for: .touchUpInside)
    }
///    On Click Close Button
    @objc func onClickCloseBtnTouchUpInside(){
        if cardViews.isEmpty == false {
            setBoolUserDefaultValue(value: true, key: .isCardUnderSwipe)
            cardViews.first?.animateView(swipeDirRight: false, card: cardViews.first!)
        }
    }
    
///    On Click Close Button
    @objc func onClickDoneBtnTouchUpInside(){
        if cardViews.isEmpty == false {
            setBoolUserDefaultValue(value: true, key: .isCardUnderSwipe)
            cardViews.first?.animateView(swipeDirRight: true, card: cardViews.first!)
        }
        
    }
    
///    To reload All Cards In PostVC
    func reloadData() {
        removeAllCardViews()
        guard let datasource = dataSource else { return }
        setNeedsLayout()
        layoutIfNeeded()
        curCardNo = 0
        numberOfCardsToShow = datasource.numberOfCardsToShow()
        remainingcards = numberOfCardsToShow
        totalNumberOfCards = numberOfCardsToShow
        cardsToBeVisible = 2
        
        for i in 0..<min(cardsToBeVisible , numberOfCardsToShow) {
            addCardView(cardView: datasource.card(at: i), atIndex: i )
        }
    }
    
    func addCardsOfpagination(){
        
        guard let datasource = dataSource else { return }
        curCardNo = 0
        numberOfCardsToShow = datasource.numberOfCardsToShow()
        remainingcards = numberOfCardsToShow
        totalNumberOfCards = numberOfCardsToShow
        cardsToBeVisible = 2
        
        for i in 0..<min(cardsToBeVisible , numberOfCardsToShow) {
            addCardView(cardView: datasource.card(at: i), atIndex: -1 )
        }
    }

    //MARK: - Configurations

    private func addCardView(cardView: SwipeCardView, atIndex index: Int) {
        printLog(string : "In addCardView")
        cardView.delegate = self
        addCardFrame(index: index, cardView: cardView)
        self.layoutIfNeeded()
        cardViews.append(cardView)
        insertSubview(cardView, at: 0)
        remainingcards -= 1
    }
    
///    To Add Card In Frame
    func addCardFrame(index: Int, cardView: SwipeCardView) {
        printLog(string : "In addCardFrame")
        if index != -1 {
            var cardViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            cardView.center.y = UIScreen.main.bounds.height / 4
            let verticalInset = CGFloat(index) * self.verticalInset
            
            cardViewFrame.origin.y += verticalInset
            cardView.frame = cardViewFrame
            
            UserDefaults.standard.set(cardView.center.x, forKey: "centerXAnchor")
            UserDefaults.standard.set(cardView.center.y, forKey: "centerYAnchor")
        }
    }
    
///    To Remove  Card In Frame After
    private func removeAllCardViews() {
        printLog(string : "In removeAllCardViews")
        for cardView in visibleCards {
            cardView.removeFromSuperview()
        }
        cardViews = []
    }
///    Tell us Card Is Right Swipped Or Left
    func cardSwipeRight(){
        myDelegate?.checkCardIsRightSwipped()
    }
///    Tell us Card Is Right Swipped Or Left
    func cardSwipeLeft(){
        myDelegate?.checkCardIsLeftSwipped()
    }
    
    func onTapCardViewUserProfile(userID: Int) {
        myDelegate?.onTapOpenUserProfile(userID: userID)
    }
    
    

///    Delegate Method Where User Swipe Ended
    func swipeDidEnd(on view: SwipeCardView) {
        guard let datasource = dataSource else { return }
        if !cardViews.isEmpty{
            cardViews.remove(at: 0)
        }
        if remainingcards > 0 {
            let newIndex = datasource.numberOfCardsToShow() - remainingcards
            addCardView(cardView: datasource.card(at: newIndex), atIndex: 2)
            for (cardIndex, cardView) in cardViews.enumerated() {
                cardView.center = self.center
                self.addCardFrame(index: cardIndex, cardView: cardView)
                self.layoutIfNeeded()
            }
        }
        else{
            for (cardIndex, cardView) in cardViews.enumerated() {
                cardView.center = self.center
                self.addCardFrame(index: cardIndex, cardView: cardView)
                self.layoutIfNeeded()
            }
        }
        
    }
///    Delegate Method WHere Users Front Card Goes Back
    func sendCardToBack(view: SwipeCardView) {
        self.sendSubviewToBack(view)
    }
    
}

