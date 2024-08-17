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
    
    @Published var themes = MemorizeTheme.builtins
    @Published var cursorIndex = 0
}

extension MemorizeTheme {
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
