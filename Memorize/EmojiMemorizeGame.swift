//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import Foundation

typealias Game = MemorizeGame<String>
typealias Card = Game.Card

class EmojiMemorizeGame: ObservableObject {
    @Published private var memorizeGame: Game
    
    init(theme: EmojiTheme = EmojiTheme(name: "default", color: EmojiTheme.colors.blue, emojis: "⚠️")) {
        memorizeGame = Game(cardContents: theme.emojis.contentify())
    }
    
    var cards: Array<Card> {
        memorizeGame.cards
    }
    
    // MARK: - Intents
    
    func choose(card: Card) -> Void {
        memorizeGame.choose(card: card)
    }
}

extension String {
    func contentify() -> Array<String> {
        self.map { String($0) }
    }
}
