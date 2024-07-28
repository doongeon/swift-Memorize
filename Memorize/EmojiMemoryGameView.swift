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
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .padding()
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
                spacing: 0) {
                    ForEach(viewModel.cards){ card in
                    CardView(card)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
            .padding()
        }
    }
    
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
        .aspectRatio(2/3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame())
}
