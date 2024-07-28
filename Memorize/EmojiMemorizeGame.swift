//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by 나동건 on 7/27/24.
//

import Foundation

class EmojiMemorizeGame: ObservableObject {
    private static let tropical: Array<String> = ["🌺", "🌴","🍹","🐠", "🏝️", "🍋‍🟩", "🦜", "🦩", "🏖️", "🥭"]
    
    private static func createMemorizeGame() -> MemorizeGame<String> {
        return MemorizeGame<String>(numOfPairOfCards: 8) { itemIndex in
            if(tropical.indices.contains(itemIndex)) {
                return tropical[itemIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemorizeGame()
    
    var cards: Array<MemorizeGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
}
