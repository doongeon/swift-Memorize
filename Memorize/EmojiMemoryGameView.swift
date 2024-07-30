//
//  EmojiMemoryGameView.swift
//  Memorized//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    var body: some View {
        VStack{
            title
            cards
                .animation(.default, value: viewModel.cards)
            Button(action: {
                viewModel.newGame()
            }, label: {
                VStack(spacing: 10) {
                    Image(systemName: "gamecontroller.fill")
                        .imageScale(.medium)
                        .font(.title)
                    Text("New Game")
                }
            })
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
                        .foregroundColor(ColorConverter.convert(viewModel.colorTheme))
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
            
            base.fill(.white)
            base.stroke(lineWidth: 2)
            card.isFaceUp ? (
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.001)
                    .aspectRatio(1, contentMode: .fit)
            ) : nil
                
            base.fill().opacity(card.isFaceUp ? 0 : 1)
            
        }
        .aspectRatio(2/3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        .opacity(card.isMatch ? 0 : 1)
    }
}

struct ColorConverter {
    static func convert(_ color: String) -> Color {
        switch(color) {
        case "red":
            return .red
        case "pink":
            return .pink
        case "grey":
            return .gray
        case "blue":
            return .blue
        case "green":
            return .green
        case "purple":
            return .purple
        default:
            return .black
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemorizeGame())
}
