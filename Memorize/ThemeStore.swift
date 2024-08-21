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
        if let autosavedData = try? Data(contentsOf: autosaveURL),
           let decodedData = try? JSONDecoder().decode(Array<EmojiTheme>.self, from: autosavedData) {
            themes = decodedData
        }
    }
    
    @Published var cursorIndex = 0
    @Published var themes = EmojiTheme.builtins {
        didSet {
            if themes.isEmpty {
                themes = oldValue
            }
            autosave()
        }
    }
    
    private let autosaveURL: URL = URL.documentsDirectory.appendingPathComponent("autosavedThemeStore.themestore")
    
    private func autosave() -> Void {
        save(to: autosaveURL)
    }
    
    private func save(to url: URL) -> Void {
        do {
            let encodedData = try JSONEncoder().encode(themes)
            try encodedData.write(to: url)
        } catch let error {
            print("ThemeStore: fail to autosave \(error)")
        }
    }
    
    // MARK: - Intents
    
    func addNewTheme() -> Void {
        themes.append(EmojiTheme(name: "", color: .blue, emojis: ""))
    }
    
    func remove(indexSet: IndexSet) -> Void {
        indexSet.forEach({themes.remove(at: $0)})
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
