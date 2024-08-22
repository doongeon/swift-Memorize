//
//  EmojiMemoryGameView.swift
//  Memorized//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var emojiMemorizeGame: EmojiMemorizeGame
    
    var theme: EmojiTheme
    
    init(theme: EmojiTheme) {
        self.theme = theme
        emojiMemorizeGame = EmojiMemorizeGame(theme: theme)
    }
    
    var body: some View {
        GeometryReader { geometry in
            let itemWidth: CGFloat = cardWidth(cardsCount: emojiMemorizeGame.cards.count, in: geometry, aspect: 2/3)
            
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: itemWidth), spacing: 0)],
                spacing: 0
            ) {
                ForEach(emojiMemorizeGame.cards) { card in
                        view(for: card)
                            .onTapGesture {
                                withAnimation {
                                    emojiMemorizeGame.choose(card: card)
                                }
                            }
                            .padding(5)
                }
            }
        }
        .padding()
    }
    
    func view(for card: Card) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 15)
            base.stroke(lineWidth: 2)
            Text(card.content)
                .font(.system(size: 1000))
                .minimumScaleFactor(0.001)
                .aspectRatio(1, contentMode: .fit)
            
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .foregroundColor(theme.getColor())
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
    
    func cardWidth(cardsCount: Int, in geometry: GeometryProxy, aspect: CGFloat = 2/3) -> CGFloat {
        var numberOfCol: CGFloat = 1
        var numberOfRow: CGFloat = CGFloat(cardsCount) / numberOfCol
        var cardHeight = geometry.size.width / aspect
        while (CGFloat(numberOfRow) * cardHeight) > geometry.size.height {
            numberOfCol += 1
            numberOfRow = (CGFloat(cardsCount) / numberOfCol).rounded(.up)
            let cardWidth = geometry.size.width / CGFloat(numberOfCol)
            cardHeight = cardWidth / aspect
        }
        return cardHeight * aspect
    }
}

#Preview {
    EmojiMemoryGameView(theme: ThemeStore(name: "Preview").themes.first!)
}
