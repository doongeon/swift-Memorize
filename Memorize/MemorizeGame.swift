//
//  MemorizeModel.swift
//  Memorize
//
//  Created by 나동건 on 7/27/24.
//

import Foundation

struct MemorizeGame<CardContent> {
    private(set) var cards: Array<Card> = []
    
    init(numOfPairOfCards: Int, getCardContent: (Int) -> CardContent) {
        for pairIndex in 0..<max(2,numOfPairOfCards) {
            let card = Card(content: getCardContent(pairIndex))
            cards.append(card)
            cards.append(card)
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func choose() -> Void {
        
    }
    
    struct Card {
        var isFaceUp: Bool = true
        var isMatch: Bool = false
        let content: CardContent
    }
}
