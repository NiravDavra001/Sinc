//
//  SwipeCardView.swift
//
//

import UIKit
//create Custom Swipable Card
class SwipeCardView : UIView {
    
    var isTapped = false
    var isRightSwipe = false
    
    var curCard = 0
    var currRotatedCard = 0
    var manageOpacity = 0.04
    var previousOpacity = 0.0
    var divisor : CGFloat = 0
    
    var dataSource : CardsDataModel?
    var delegate : SwipeCardsDelegate?
    
    var rotationOffset = CGFloat.pi / 80
    var lastRotation = CGFloat.zero
    var cardCenter = CGPoint.zero
    
    var swipeView : UIView!
    var shadowView : UIView!
    var mainView = UIView()
    var closeButton = UIButton()
    var doneButton = UIButton()
    
    //MARK: - Init
    convenience init(data: CardsDataModel){
        self.init()
        self.dataSource = data
        
        configureShadowView()
        configureSwipeView()
        addPanGestureOnCards()
        configureTapGesture()
    }
/// configureShadowView  -> To Confogure Shadow In cards
    func configureShadowView() {
        shadowView = UIView()
        shadowView.backgroundColor = .white
        addSubview(shadowView)
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        shadowView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 327/375).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 327/375 * 436/327).isActive = true
        
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 30
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        shadowView.layer.cornerRadius = 15
    }
/// configureSwipeView  -> To Confogure swipable Card
    func configureSwipeView() {
        
        let profileName = dataSource?.cardName ?? ""
        let profileAge = dataSource?.cardAge  ?? ""
        let profileDistance = dataSource?.cardDistance ?? 0
        let profileOccupation = dataSource?.cardOcuupation ?? ""
        let profileImg = dataSource?.cardImage ?? ""
        self.tag = dataSource?.cardId ?? 0
        
        swipeView = customView(name: profileName, age: profileAge, occupation: profileOccupation, distance: "\(profileDistance) Miles Away", imageName: profileImg)
        
        swipeView.layer.cornerRadius = 15
        swipeView.backgroundColor = .black
        swipeView.clipsToBounds = true
        shadowView.addSubview(swipeView)
        
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        swipeView.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
        swipeView.backgroundColor = .white
    }
/// manage tap from here
    
    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
        delegate?.onTapCardViewUserProfile(userID: self.tag)
    }
    
/// configureSwipeView  -> configureTapGesture on card to Swipe
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
///         to Handle Swipe Card
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        if getBoolUserDefaultValue(key: .isCardUnderSwipe) {
            return
        }
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
       
        switch sender.state {
        case .ended:
            if !getBoolUserDefaultValue(key: .isCardUnderSwipe) {
                if (card.center.x) > UIScreen.main.bounds.width / 2 + 60 {
                    printLog(string : "right Swipe")
                    setBoolUserDefaultValue(value: true, key: .isCardUnderSwipe)
                    animateView(swipeDirRight: true, card: card)
                    return
                }else if card.center.x < UIScreen.main.bounds.width / 2 - 60 {
                    setBoolUserDefaultValue(value: true, key: .isCardUnderSwipe)
                    printLog(string : "left Swipe")
                    animateView(swipeDirRight: false, card: card)
                }
                else{
                    UIView.animate(withDuration: 0.5) {
                        card.transform = .identity
                        card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                        self.layoutIfNeeded()
                    }
                }
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            
            
        default:
            break
        }
    }
    
///    Common Func For Animation for View
    func animateView(swipeDirRight : Bool ,card : SwipeCardView){
        
        UIView.animate(withDuration: 0.5, animations: {
            if swipeDirRight {
                card.center = CGPoint(x: UIScreen.main.bounds.width * 2, y: card.center.y)
                let rotation = CGFloat(-30.0)
                card.transform = CGAffineTransform(rotationAngle: rotation)
            }
            else{
                card.center = CGPoint(x: -UIScreen.main.bounds.width * 2, y: card.center.y)
                let rotation = CGFloat(30.0)
                card.transform = CGAffineTransform(rotationAngle: rotation)
            }
        }) { (completed) in
            if swipeDirRight {
                self.delegate?.cardSwipeRight()
            }
            else{
                self.delegate?.cardSwipeLeft()
            }
            self.delegate?.swipeDidEnd(on: card)
            setBoolUserDefaultValue(value: false, key: .isCardUnderSwipe)
        }
    }
    
}
