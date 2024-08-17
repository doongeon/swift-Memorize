//
//  MemorizeTheme.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import Foundation

struct MemorizeTheme: Identifiable {
    var name: String
    var color: colors
    var emojis: String
    var id = UUID()
    
    static var builtins: Array<MemorizeTheme> {
        [
            MemorizeTheme(name: "Tropical", color: colors.red, emojis: "🌴🥥🍍🏝️🌺🌞🐚"),
            MemorizeTheme(name: "Ocean", color: colors.blue, emojis: "🌊🏝️🐠🐬🐳🐚🏖️⛵🚤"),
            MemorizeTheme(name: "Asia", color: colors.green, emojis: "🏯🎎🥋🐉🍜🍣🌸")
        ]
    }
    
    enum colors {
        case red 
        case blue
        case green
    }
}
