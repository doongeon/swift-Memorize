//
//  MainView.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import SwiftUI

struct MainView: View {
    typealias Theme = EmojiTheme
    
    @ObservedObject var game: EmojiMemorizeGame
    @EnvironmentObject var themeStore: ThemeStore
    
    init(game: EmojiMemorizeGame) {
        self.game = game
    }
    
    @State private var showEditor = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(themeStore.themes) {theme in
                    NavigationLink(value: theme) {
                        label(for: theme)
                            .contextMenu {
                                ActionButton(title: "Delete", systemImage: "trash", role: .destructive) {
                                    
                                }
                                ActionButton(title: "Edit", systemImage: "pencil") {
                                    showEditor = true
                                }
                            }
                    }
                }
            }
            .navigationDestination(for: Theme.self) { theme in
                EmojiMemoryGameView(theme: theme)
            }
            .navigationTitle("Memorize")
            .sheet(isPresented: $showEditor) {
                ThemeEditView()
            }
        }
    }
    
    func label(for theme: Theme) -> some View {
        Label {
            HStack {
                Text(theme.name)
                Spacer()
                Text("\(theme.emojis.count * 2) cards")
                    .foregroundStyle(.gray)
            }
            
        } icon: {
            Text(theme.icon)
        }
    }
}

struct ThemeGrid<Item: Identifiable, ItemView: View>: View   {
    let contents: (Item) -> ItemView
    let items: Array<Item>
    
    init(items: Array<Item>, content: @escaping (Item) -> ItemView) {
        self.items = items
        self.contents = content
    }
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(spacing: 0), GridItem(spacing: 0)],
            alignment: .leading,
            spacing: 0
        ) {
            ForEach(items) {item in
                contents(item)
            }
        }
    }
}

struct ActionButton: View {
    let title: String
    let systemImage: String?
    let role: ButtonRole?
    let action: () -> Void
    
    init(
        title: String,
        systemImage: String? = nil,
        role: ButtonRole? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.role = role
        self.action = action
    }
    
    var body: some View {
        Button(role: role) {
            action()
        } label: {
            if let systemImage {
                HStack {
                    Text(title)
                    Spacer()
                    Image(systemName: systemImage)
                }
            } else {
                Text(title)
            }
        }
    }
}

#Preview {
    @StateObject var themeStore: ThemeStore = ThemeStore(name: "Main Preview")
    struct Preview: View {
        var body: some View {
            MainView( game: EmojiMemorizeGame())
        }
    }
    
    return Preview()
        .environmentObject(themeStore)
}
