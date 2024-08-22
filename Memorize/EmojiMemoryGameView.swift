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
    
    @State var cardCauseScoreChange: Card?
    @State var scoreChange: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("score: \(emojiMemorizeGame.score)")
                    .font(.title2)
                    .animation(nil)
            }
            GeometryReader { geometry in
                let itemWidth: CGFloat = cardWidth(cardsCount: emojiMemorizeGame.cards.count, in: geometry, aspect: 2/3)
                
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: itemWidth), spacing: 0)],
                    spacing: 0
                ) {
                    ForEach(emojiMemorizeGame.cards, id: \.self.id) { card in
                        CardView(card: card, theme: theme)
                            .padding(5)
                            .overlay {
                                if let cardToCompare = cardCauseScoreChange,
                                   cardToCompare.id == card.id {
                                    FlyingNumber(number: scoreChange)
                                }
                            }
                            .onTapGesture {
                                choose(card: card)
                            }
                            .zIndex(cardCauseScoreChange == card ? 1 : 0)
                    }
                }
            }
            .navigationTitle(theme.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .padding()
    }
    
    func choose(card: Card) -> Void {
        withAnimation {
            let scoreBefore = emojiMemorizeGame.score
            emojiMemorizeGame.choose(card: card)
            let scoreAfter = emojiMemorizeGame.score
            if scoreBefore != scoreAfter {
                cardCauseScoreChange = card
                scoreChange = scoreAfter - scoreBefore
            }
        }
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

struct CardView: View, Animatable {
    var card: MemorizeGame<String>.Card
    var theme: EmojiTheme
    
    init(card: MemorizeGame<String>.Card, theme: EmojiTheme) {
        self.card = card
        self.theme = theme
        rotation = card.isFaceUp ? 0 : 180
    }
    
    var rotation: Double
    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue}
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 15)
            base.stroke(lineWidth: 2)
            Text(card.content)
                .font(.system(size: 1000))
                .minimumScaleFactor(0.001)
                .aspectRatio(1, contentMode: .fit)
            
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .aspectRatio(2/3, contentMode: .fit)
        .foregroundColor(theme.getColor())
        .rotation3DEffect(
            .degrees(rotation),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
    }
}

#Preview {
    EmojiMemoryGameView(theme: ThemeStore(name: "Preview").themes.first!)
}
