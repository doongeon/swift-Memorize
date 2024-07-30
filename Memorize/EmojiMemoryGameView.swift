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
            stat
            newGame
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
                        CardView(
                            card: card,
                            colorTheme: ColorConverter.convert(viewModel.colorTheme)
                        )
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
    
    var stat: some View {
        HStack{
            Text("Score \(viewModel.score)")
            Spacer()
            Text(viewModel.themeName)
        }.padding()
    }
    
    var newGame: some View {
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

struct CardView: View {
    var card: MemorizeGame<String>.Card
    var colorTheme: Color
    
    init(card: MemorizeGame<String>.Card, colorTheme: Color) {
        self.card = card
        self.colorTheme = colorTheme
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
                
            base.fill(
                LinearGradient(
                    colors: [colorTheme, .white],
                    startPoint: UnitPoint(),
                    endPoint: UnitPoint(x: 1, y: 1))
            ).opacity(card.isFaceUp ? 0 : 1)
            
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
