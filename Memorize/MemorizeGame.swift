//
//  MemorizeModel.swift
//  Memorize
//
//  Created by 나동건 on 7/27/24.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card> = []
    private var seenIds: Array<String> = []
    private(set) var score: Int = 0
    
    init(numOfPairOfCards: Int, cardContents: Array<CardContent>) {
        seenIds = []
        score = 0
        
        for pairIndex in 0..<max(2,numOfPairOfCards) {
            if (cardContents.count <= pairIndex) {
                break
            }
            cards.append(Card(content: cardContents[pairIndex], id: "\(pairIndex)a"))
            cards.append(Card(content: cardContents[pairIndex], id: "\(pairIndex)b"))
        }
        
        shuffle()
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    var indexOfOneAnyOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = ( newValue == $0 ) } }
    }
    
    mutating private func minusPoint(with cardId: Card.ID) -> Void {
        if(seenIds.contains(cardId)) {
            score-=1
        } else {
            seenIds.append(cardId)
        }
    }
    
    mutating func choose(_ card: Card) -> Void {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if(!cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatch) {
                if let indexOfPotentialMatchUpCard = indexOfOneAnyOnlyFaceUpCard {
                    if(cards[indexOfPotentialMatchUpCard].content == cards[chosenIndex].content) {
                        cards[indexOfPotentialMatchUpCard].isMatch = true
                        cards[chosenIndex].isMatch = true
                        score += 2
                    } else {
                        minusPoint(with: cards[indexOfPotentialMatchUpCard].id)
                        minusPoint(with: cards[chosenIndex].id)
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

struct Theme<CardContent> where CardContent: Hashable {
    static func validateColor(_ themeColor: String) -> String {
        if(!["red", "pink", "grey", "blue", "green", "purple"].contains(themeColor)) {
            return "red"
        }
        
        return themeColor
    }
    
    static func validateContents(_ themeContents: Array<CardContent>) -> Array<CardContent> {
        return Array(Set(themeContents))
    }
    
    let name: String;
    private let contents: Array<CardContent>
    let pairCount: Int
    let color: String
    
    init(name: String, contents: Array<CardContent>, color: String) {
        self.name = name
        self.contents = Theme<CardContent>.validateContents(contents)
        self.pairCount = Int.random(in: 2..<contents.count)
        self.color = Theme<CardContent>.validateColor(color)
    }
    
    func getContents() -> Array<CardContent> {
        return contents.shuffled()
    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
