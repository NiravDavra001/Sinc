//
//  Protocols.swift
//  TinderStack
//

import UIKit

protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
    func emptyView() -> UIView?
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
    func cardSwipeRight()
    func cardSwipeLeft()
    func sendCardToBack(view : SwipeCardView)
    func onTapCardViewUserProfile(userID : Int)
    func stopCardWhileAnimating()
}

protocol MySwipeCardDelegate {
    func checkCardIsRightSwipped()
    func checkCardIsLeftSwipped()
    func onTapOpenUserProfile(userID : Int)
    func stopCardWhileAnimating()
}
