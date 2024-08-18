//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import Foundation

struct MemorizeGame<CardContent: Equatable> {
    var cards: Array<Card>
    
    init(cardContents: Array<CardContent>) {
        cards = []
        for content in cardContents {
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    var indexOfOnlyFaceUpCard: Int? {
        get { cards.filter({$0.isFaceUp}).count > 1 ? nil : cards.indices.first(where: {cards[$0].isFaceUp}) }
        set { cards.indices.forEach({cards[$0].isFaceUp = (newValue == $0)}) }
    }
    
    mutating func choose(card: Card) -> Void {
        if let indexOfChosenCard = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[indexOfChosenCard].isFaceUp {
                if let indexOfCardToCompare = indexOfOnlyFaceUpCard {
                    if cards[indexOfCardToCompare].content == cards[indexOfChosenCard].content {
                        cards[indexOfCardToCompare].isMatch = true
                        cards[indexOfChosenCard].isMatch = true
                    }
                } else {
                    indexOfOnlyFaceUpCard = indexOfChosenCard
                }
                cards[indexOfChosenCard].isFaceUp = true
            }
        }
    }
    
    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp: Bool = false
        var isMatch: Bool = false
        
        let id = UUID()
    }
}
