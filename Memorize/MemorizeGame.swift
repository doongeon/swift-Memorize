//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import Foundation

struct MemorizeGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    init(cardContents: Array<CardContent>) {
        cards = []
        for content in cardContents {
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
//        cards.shuffle()
    }
    
    var indexOfOnlyFaceUpCard: Int? {
        get { cards.filter({$0.isFaceUp && !$0.isMatch}).count > 1 ? nil : cards.indices.first(where: {cards[$0].isFaceUp && !cards[$0].isMatch}) }
        set { cards.indices.forEach({cards[$0].isFaceUp = (newValue == $0)}) }
    }
    
    mutating func choose(card: Card) -> Void {
        if let indexOfChosenCard = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[indexOfChosenCard].isFaceUp {
                if let indexOfCardToCompare = indexOfOnlyFaceUpCard {
                    if cards[indexOfCardToCompare].content == cards[indexOfChosenCard].content {
                        cards[indexOfCardToCompare].isMatch = true
                        cards[indexOfChosenCard].isMatch = true
                        score += 4
                    } else {
                        if cards[indexOfCardToCompare].hasBeenSeen {
                            score -= 2
                        }
                        if cards[indexOfChosenCard].hasBeenSeen {
                            score -= 2
                        }
                    }
                } else {
                    indexOfOnlyFaceUpCard = indexOfChosenCard
                }
                cards[indexOfChosenCard].isFaceUp = true
            }
        }
    }
    
    struct Card: Equatable, Identifiable, Hashable {
        let content: CardContent
        var isFaceUp: Bool = false {
            didSet {
                if isMatch {
                    isFaceUp = true
                }
                if oldValue, !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatch: Bool = false
        var hasBeenSeen = false
        
        let id = UUID()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}
