//
//  EmojiMemorizeGame.swift
//  Memorize
//
//  Created by 나동건 on 7/27/24.
//

import Foundation

class EmojiMemorizeGame: ObservableObject {
    private static let themes: Array<Theme<String>> = [
        Theme(
            name: "Fruit",
            contents: ["🍋", "🍉", "🍌", "🍍", "🥑", "🍈", "🥝", "🍊", "🥥", "🫒"],
            color: "red"
        ),
        Theme(
            name: "Tropical",
            contents: ["🌺", "🌴", "🍹", "🐠", "🏝️", "🍋‍🟩", "🦜", "🦩", "🏖️", "🥭"],
            color: "pink"
        ),
        Theme(
            name: "Winter",
            contents: ["❄️", "☃️", "🎅", "🧣", "🏂", "🎿", "🧦", "🛷", "🌨️", "🧤"],
            color: "grey"
        ),
        Theme(
            name: "Animals",
            contents: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"],
            color: "blue"
        ),
        Theme(
            name: "Vehicles",
            contents: ["🚗", "🚕", "🚙", "🚌", "🚎", "🚑", "🚒", "🚐", "🚜", "🛵"],
            color: "green"
        ),
        Theme(
            name: "Space",
            contents: ["🚀", "🛸", "🌌", "🌠", "🪐", "🌕", "🛸", "👽", "🛰️", "🚀"],
            color: "purple"
        )
    ]
    
    private static func acquireTheme() -> Theme<String> {
        if let randomTheme = EmojiMemorizeGame.themes.randomElement() {
            return randomTheme
        }
        
        return EmojiMemorizeGame.themes[0] // FIXME: bogus!!
    }
    
    private static func createMemorizeGame(_ theme: Theme<String>) -> MemorizeGame<String> {
        return MemorizeGame<String>(
            numOfPairOfCards: 8,
            cardContents: theme.getContents()
        )
    }
    
    private var theme: Theme<String>
    @Published private var model: MemorizeGame<String>
    
    init() {
        theme = EmojiMemorizeGame.acquireTheme()
        model = EmojiMemorizeGame.createMemorizeGame(theme)
    }
    
    
    var cards: Array<MemorizeGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    var themeName: String {
        theme.name
    }
    
    var colorTheme: String {
        theme.color
    }
    
    // MARK: - Intents
    
    func newGame() {
        theme = EmojiMemorizeGame.acquireTheme()
        model = EmojiMemorizeGame.createMemorizeGame(theme)
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
}
