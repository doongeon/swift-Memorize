//
//  ContentView.swift
//  Memorize
//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
        }
    }
    
}

struct CardView: View {
    var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            if(isFaceUp) {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .stroke(.orange, lineWidth: 2)
                Text("🍋").font(.largeTitle)
            }
            else {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.orange)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
