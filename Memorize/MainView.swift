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
                                contextMenu(for: theme)
                            }
                    }
                }
                .onDelete { indexSet in
                    themeStore.remove(indexSet: indexSet)
                }
            }
            .navigationDestination(for: Theme.self) { theme in
                EmojiMemoryGameView(theme: theme)
            }
            .navigationTitle("Themes")
            .sheet(isPresented: $showEditor) {
                editor
            }
            
            Spacer()
            addTheme
        }
        .listStyle(.plain)
    }
    
    var editor: some View {
        ThemeEditView(
            theme: $themeStore.themes[themeStore.cursorIndex],
            showEditor: $showEditor
        )
            .font(nil)
    }
    
    var addTheme: some View {
        return HStack(alignment: .lastTextBaseline) {
            Spacer()
            Button {
                addNewTheme()
            } label: {
                label()
            }
            .padding()
        }
        .padding()
        
        func label() -> some View {
            return ZStack {
                Circle()
                    .fill(.blue)
                    .frame(minWidth: 50, maxWidth: 50)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    )
            }
        }
        
        func addNewTheme() -> Void {
            themeStore.addNewTheme()
            themeStore.setCursor(to: themeStore.themes.last!)
            showEditor = true
        }
    }
    
    private func contextMenu(for theme: EmojiTheme) -> some View {
        Group {
            ActionButton(title: "Delete", systemImage: "trash", role: .destructive) {
                
            }
            ActionButton(title: "Edit", systemImage: "pencil") {
                themeStore.setCursor(to: theme)
                showEditor = true
            }
        }
    }
    
    func label(for theme: Theme) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(theme.name)
                Spacer()
                Text("\(theme.emojis.count) pairs")
                    .foregroundStyle(.gray)
            }
            Text(theme.emojis).lineLimit(1)
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
