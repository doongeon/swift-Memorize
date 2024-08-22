//
//  MemorizeTheme.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import Foundation

struct EmojiTheme: Identifiable, Codable, Hashable {
    var name: String
    var color: Int
    var emojis: String
    var icon: String {
        if let firstEmoji = emojis.first {
            return String(firstEmoji)
        } else {
            return "⚠️"
        }
    }
    var id = UUID()
    
    mutating func setColor(rgb newColor: Int) -> Void {
        color = newColor
    }
    
    mutating func addEmojis(_ emojisToAdd: String) -> Void {
        emojisToAdd.forEach({
            if !emojis.contains($0) {
                emojis = String($0) + emojis
            }
        })
    }
    
    mutating func remove(_ emojiToRemove: String) -> Void {
        emojis = emojis.filter({String($0) != emojiToRemove})
    }
    
    static var builtins: Array<EmojiTheme> {
        [
            EmojiTheme(name: "Tropical", color: 0xC7253E, emojis: "🌴🥥🍍🏝️🌺🌞🐚"),
            EmojiTheme(name: "Ocean", color: 0x134B70, emojis: "🌊🏝️🐠🐬🐳🐚🏖️⛵🚤"),
            EmojiTheme(name: "Asia", color: 0xEECAD5, emojis: "🏯🎎🥋🐉🍜🍣🌸")
        ]
    }
}
