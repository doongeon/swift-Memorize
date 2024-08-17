//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var emojiMemorizeGame = EmojiMemorizeGame()
    @StateObject var themeStore = ThemeStore(name: "Main")
    var body: some Scene {
        WindowGroup {
            MainView(game: emojiMemorizeGame)
                .environmentObject(themeStore)
        }
    }
}
