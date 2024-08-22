//
//  ThemeEditView.swift
//  Memorize
//
//  Created by 나동건 on 8/18/24.
//

import SwiftUI

struct ThemeEditView: View {
    @EnvironmentObject var themeStore: ThemeStore
    
    @Binding var theme: EmojiTheme
    @Binding var showEditor: Bool
    
    @State var colorToChange: Color = .white
    @State var emojisToAdd = ""
    
    enum Focused {
        case name
        case emojis
    }
    
    @FocusState var focused: Focused?
    
    var body: some View {
        NavigationStack {
            Form {
                colorSection
                nameSection
                emojiSection
            }
            .toolbar() {
                toolbarView
            }
            .navigationTitle("Edit")
        }
        .onAppear() {
            setFocus()
        }
    }
    
    var colorSection: some View {
        Section(header: Text("Color")) {
            ColorPicker(selection: $colorToChange, supportsOpacity: false) {
                Text("테마 색상")
            }
            .onChange(of: colorToChange) {
                theme.setColor(rgb: colorToChange.uiColor().rgb)
            }
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField(
                "Name",
                text: $theme.name
            )
            .focused($focused, equals: .name)
        }
    }
    
    var emojiSection: some View {
        Section(header: Text("Emojis")) {
            TextField("Add emoji", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { oldValue, newValue in
                    addEmoji(newValue: newValue)
                }
                .focused($focused, equals: .emojis)
            Emojis()
        }
    }
    
    func addEmoji(newValue: String) -> Void {
        emojisToAdd = newValue.unique()
        theme.addEmojis(emojisToAdd)
    }
    
    var toolbarView: some View {
        Button {
            showEditor = false
        } label: {
            Text("Done")
        }
    }
    
    func Emojis() -> some View {
        return VStack(alignment: .trailing) {
            Text("tap to remove")
                .foregroundColor(.gray)
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 40), spacing: 0)],
                spacing: 0
            ) {
                ForEach(
                    theme.emojis.map({String($0)}),
                    id: \.self
                ) { emoji in
                    Text(emoji)
                        .padding(5)
                        .onTapGesture {
                            withAnimation {
                                removeEmoji(emoji)
                            }
                        }
                }
            }
        }
        
        func removeEmoji(_ emoji: String) -> Void {
            withAnimation {
                theme.remove(emoji)
            }
        }
    }
    
    func setFocus() -> Void {
        if theme.name.isEmpty {
            focused = .name
        } else {
            focused = .emojis
        }
    }
}

extension String {
    func unique() -> String {
        var result = ""
        for char in self {
            if(!result.contains(char)) {
                result.append(char)
            } else {
                continue
            }
        }
        return result
    }
}



//#Preview {
//    struct Preview: View {
//        @State var showEditor = true
//        
//        var body: some View {
//            ThemeEditView(showEditor: $showEditor)
//        }
//    }
//    
//    return Preview()
//}
