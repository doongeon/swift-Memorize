//
//  ContentView.swift
//  Memorized//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    let fruits: Array<String> = ["🍋", "🍉","🍌","🍍", "🥑", "🍈", "🥝", "🥭", "🥥", "🫒"]
    @State var numCards: Int = 4
    
    var body: some View {
        VStack{
            title
            cards
            Spacer()
            cardCountAdjuster
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!")
            .font(.largeTitle)
    }
    
    func acquireCardItems() -> Array<String> {
        Array(fruits[0...numCards]) + Array(fruits[0...numCards])
    }
    
    var cards: some View {
        ScrollView {
            let cardItems = acquireCardItems().shuffled()
            
            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 60)),
                GridItem(.adaptive(minimum: 60)),
            ], spacing: 20) {
                ForEach(0..<cardItems.count, id: \.self){
                    index in CardView(content: cardItems[index])
                }
            }
            .padding()
        }
    }
    
    var cardCountAdjuster: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .padding()
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(
            action: {
                numCards += offset
            },
            label: {
                Image(systemName: symbol)
            }
        )
        .imageScale(.large)
        .font(.title)
        .disabled(numCards + offset < 0 || numCards + offset >= fruits.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "plus.circle.fill")
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            Group {
                base
                    .fill(.white)
                base
                    .stroke(.red, lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            
            base.fill(.red).opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        .aspectRatio(2/3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
