//
//  cardsDataModel.swift
//

import UIKit
///  data model Of Card In which Card Get Data from this model class
struct CardsDataModel {
    var cardImage: String?
    var cardName : String?
    var cardId : Int?
    var cardAge : String?
    var cardOcuupation : String?
    var cardDistance : Float?
    
    init(cardImage : String?,cardName : String?,cardId : Int?,cardAge : String?,cardOcuupation : String?,cardDistance : Float?) {
        self.cardImage = cardImage
        self.cardName = cardName
        self.cardId = cardId
        self.cardAge = cardAge
        self.cardOcuupation = cardOcuupation
        self.cardDistance = cardDistance
    }
    
}
