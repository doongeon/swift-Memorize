//
//  EmojiMemoryGameView.swift
//  Memorized//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    let fruits: Array<String> = ["🍋", "🍉","🍌","🍍", "🥑", "🍈", "🥝", "🍊", "🥥", "🫒"]
    let tropical: Array<String> = ["🌺", "🌴","🍹","🐠", "🏝️", "🍋‍🟩", "🦜", "🦩", "🏖️", "🥭"]
    let winter: Array<String> = ["❄️", "☃️","🎅","🧣", "🏂", "🎿", "🧦", "🛷", "🌨️", "🧤"]
    
    enum cardThemes {
        case fruits, tropical, winter
    }
    
    @State var theme = cardThemes.fruits
    
    var body: some View {
        VStack{
            title
            cards
            Button("Shuffle") {
                viewModel.shuffle()
            }
//            Spacer()
//            cardCountAdjuster
//            themeSelector

        }
    }
    
//    var themeSelector: some View {
//        HStack(spacing: 40) {
//            fruitThemeSelector
//            tropicalThemeSelector
//            winterThemeSelector
//        }
//    }
//    
//    func themeSelector(theme selectedTheme: cardThemes, symbol: String , content: String) -> some View {
//        Button (
//            action: {
//                theme = selectedTheme
//            },
//            label: {
//                VStack{
//                    Text(symbol)
//                        .font(.largeTitle)
//                    Text(content)
//                }
//            }
//        )
//    }
//    
//    var fruitThemeSelector: some View {
//        themeSelector(theme: cardThemes.fruits, symbol: "🍋", content: "Fruit")
//    }
//    
//    var tropicalThemeSelector: some View {
//        themeSelector(theme: cardThemes.tropical, symbol: "🌺", content: "Tropical")
//    }
//    
//    var winterThemeSelector: some View {
//        themeSelector(theme: cardThemes.winter, symbol: "❄️", content: "Winter")
//    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .padding()
    }
    
//    func acquireCardItems() -> Array<String> {
//        var cardItems: Array<String> = []
//        switch(theme) {
//            case cardThemes.fruits:
//                cardItems = fruits
//                break
//            case cardThemes.tropical:
//                cardItems = tropical
//                break
//            case cardThemes.winter:
//                cardItems = winter
//        }
//        return Array(cardItems[0..<numCards] + cardItems[0..<numCards])
//    }
    
    var cards: some View {
        ScrollView {
            let cards = viewModel.cards
            
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
                spacing: 0) {
                ForEach(0..<cards.count, id: \.self){ index in
                    CardView(cards[index])
                        .padding(4)
                }
            }
            .padding()
        }
    }
    
//    var cardCountAdjuster: some View {
//        HStack {
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .padding()
//    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(
//            action: {
//                numCards += offset
//            },
//            label: {
//                Image(systemName: symbol)
//            }
//        )
//        .imageScale(.large)
//        .font(.title)
//        .disabled(numCards + offset < 0 || numCards + offset >= fruits.count)
//    }
//    
//    var cardRemover: some View {
//        cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
//    }
//    
//    var cardAdder: some View {
//        cardCountAdjuster(by: +1, symbol: "plus.circle.fill")
//    }
    
}

struct CardView: View {
    var card: MemorizeGame<String>.Card
    
    init(_ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base.fill(.white)
                base.stroke(.red, lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.001)
                    .aspectRatio(1, contentMode: .fit)
            }
            
            base.fill(.red).opacity(card.isFaceUp ? 0 : 1)
        }
//        .onTapGesture {
//            card.isFaceUp.toggle()
//        }
        .aspectRatio(2/3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame())
}
