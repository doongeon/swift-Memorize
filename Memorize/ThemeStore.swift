//
//  ThemeStore.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import SwiftUI

class ThemeStore: ObservableObject {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    @Published var themes = EmojiTheme.builtins {
        didSet {
            if themes.isEmpty {
                themes = oldValue
            }
        }
    }
    @Published var cursorIndex = 0
    
    // MARK: - Intents
    
    func addNewTheme() -> Void {
        themes.append(EmojiTheme(name: "", color: .blue, emojis: ""))
    }
    
    func setCursor(to theme: EmojiTheme) -> Void {
        if let indexOfTheme = themes.firstIndex(where: {$0.id == theme.id}) {
            cursorIndex = indexOfTheme
        } else {
            cursorIndex = 0
        }
    }
}

extension EmojiTheme {
    func getColor() -> Color {
        switch(color) {
        case .blue:
            return .blue
        case .green:
            return .green
        case .red:
            return .red
        }
    }
}
