//
//  ThemeEditView.swift
//  Memorize
//
//  Created by 나동건 on 8/18/24.
//

import SwiftUI

struct ThemeEditView: View {
    @EnvironmentObject var themeStore: ThemeStore
    
    @State var nameToChange = ""
    @State var emojisToAdd = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name")) {
                    TextField(
                        "Name",
                        text: $themeStore.themes[themeStore.cursorIndex].name
                    )
                }
                
                Section(header: Text("Emojis")) {
                    TextField("Add emoji", text: $emojisToAdd)
                        .onChange(of: emojisToAdd) { oldValue, newValue in
                            addEmoji(newValue: newValue)
                        }
                    Emojis()
                }
            }
            .navigationTitle("Edit")
        }
    }
    
    func addEmoji(newValue: String) -> Void {
        emojisToAdd = newValue.unique()
        themeStore.themes[themeStore.cursorIndex].addEmojis(emojisToAdd)
    }
    
    func Emojis() -> some View {
        VStack(alignment: .trailing) {
            Text("tap to remove")
                .foregroundColor(.gray)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(
                    themeStore.themes[themeStore.cursorIndex].emojis.map({String($0)}),
                    id: \.self
                ) { emoji in
                    Text(emoji)
                        .padding(5)
                        .onTapGesture {
                            withAnimation {
                                themeStore.themes[themeStore.cursorIndex].remove(emoji)
                            }
                        }
                }
            }
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



#Preview {
    ThemeEditView()
}
