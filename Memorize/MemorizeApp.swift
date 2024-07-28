//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemorizeGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
