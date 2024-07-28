//
//  MemorizeModel.swift
//  Memorize
//
//  Created by 나동건 on 7/27/24.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> = []
    
    init(numOfPairOfCards: Int, getCardContent: (Int) -> CardContent) {
        for pairIndex in 0..<max(2,numOfPairOfCards) {
            cards.append(Card(content: getCardContent(pairIndex), id: "\(pairIndex + 1)a"))
            cards.append(Card(content: getCardContent(pairIndex), id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfOneAnyOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ( newValue == $0 ) } }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) -> Void {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if(!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatch) {
                if let indexOfPotentialMatchUpCard = indexOfOneAnyOnlyFaceUpCard {
                    if(cards[indexOfPotentialMatchUpCard].content == cards[chosenIndex].content) {
                        cards[indexOfPotentialMatchUpCard].isMatch = true
                        cards[chosenIndex].isMatch = true
                    }
                } else {
                    indexOfOneAnyOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatch: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down")"
        }
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
