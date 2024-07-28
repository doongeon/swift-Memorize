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
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func choose() -> Void {
        
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
