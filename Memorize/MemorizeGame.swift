//
//  MemorizeGame.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import Foundation

struct MemorizeGame<CardContent> {
    var cards: Array<Card>
    
    init(cardContents: Array<CardContent>) {
        cards = []
        for content in cardContents {
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) -> Void {
        if let indexOfCard = cards.firstIndex(where: {$0.id == card.id}) {
            cards[indexOfCard].isFaceUp.toggle()
        }
    }
    
    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp: Bool = true
        var isMatch: Bool = false
        
        let id = UUID()
    }
}
