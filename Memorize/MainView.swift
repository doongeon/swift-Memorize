//
//  MainView.swift
//  Memorize
//
//  Created by 나동건 on 8/17/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var game: EmojiMemorizeGame
    @EnvironmentObject var themeStore: ThemeStore
    
    init(game: EmojiMemorizeGame) {
        self.game = game
    }
    
    var body: some View {
        NavigationStack {
            Text("choose theme")
                .foregroundStyle(.gray)
            ThemeGrid(items: themeStore.themes) { theme in
                NavigationLink {
                    EmojiMemoryGameView(theme: theme)
                        .navigationTitle(theme.name)
                } label: {
                    NavigateCard(theme: theme)
                        .padding(5)
                        .contextMenu {
                            ActionButton(title: "Delete", systemImage: "trash", role: .destructive)
                            ActionButton(title: "Edit", systemImage: "pencil")
                        }
                }
            }
            .padding()
            
            .navigationTitle("Memorize")
            Spacer()
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

struct NavigateCard: View {
    let theme: MemorizeTheme
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 15)
            base
                .stroke(theme.getColor(), lineWidth: 5)
                .opacity(0.5)
            VStack {
                emoji
                description
            }
            .padding()
        }
    }
    
    var emoji: some View {
        Text(String(theme.emojis.first!))
            .font(.system(size: 1000))
            .minimumScaleFactor(0.001)
            .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    }
    
    var description: some View {
        Group {
            Text(theme.name)
                .font(.title)
                .foregroundStyle(.black)
            Text("\(theme.emojis.count * 2) cards")
                .foregroundStyle(.black)
        }
    }
}

struct ActionButton: View {
    let title: String
    let systemImage: String?
    let role: ButtonRole?
    
    init(title: String, systemImage: String? = nil, role: ButtonRole? = nil) {
        self.title = title
        self.systemImage = systemImage
        self.role = role
    }
    
    var body: some View {
        Button(role: role) {
            print(title)
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
