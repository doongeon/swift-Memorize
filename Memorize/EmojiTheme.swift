//
//  MemorizeTheme.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import Foundation

struct EmojiTheme: Identifiable, Hashable {
    var name: String
    var color: colors
    var emojis: String
    var icon: String {
        if let firstEmoji = emojis.first {
            return String(firstEmoji)
        } else {
            return "⚠️"
        }
    }
    var id = UUID()
    
    static var builtins: Array<EmojiTheme> {
        [
            EmojiTheme(name: "Tropical", color: colors.red, emojis: "🌴🥥🍍🏝️🌺🌞🐚"),
            EmojiTheme(name: "Ocean", color: colors.blue, emojis: "🌊🏝️🐠🐬🐳🐚🏖️⛵🚤"),
            EmojiTheme(name: "Asia", color: colors.green, emojis: "🏯🎎🥋🐉🍜🍣🌸")
        ]
    }
    
    enum colors {
        case red 
        case blue
        case green
    }
}
