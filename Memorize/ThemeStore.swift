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
        themes.append(EmojiTheme(name: "", color: Color.green.uiColor().rgb, emojis: ""))
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
    
    func setColor(color: Color) -> Void {
        themes[cursorIndex].setColor(rgb: color.uiColor().rgb)
    }
}

extension EmojiTheme {
    func getColor() -> Color {
        color.toColor()
    }
}

extension Color {
    func uiColor() -> UIColor {
        if #available(iOS 14.0, *) {
            return UIColor(self)
        } else {
            let components = self.components()
            return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
        }
    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let color = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}

extension UIColor {
    var rgb: Int {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (Int(red * 255) << 16) + (Int(green * 255) << 8) + Int(blue * 255)
    }
}

extension Int {
    func toColor() -> Color {
        let red = Double((self >> 16) & 0xFF) / 255.0
        let green = Double((self >> 8) & 0xFF) / 255.0
        let blue = Double(self & 0xFF) / 255.0
        return Color(red: red, green: green, blue: blue)
    }
}
