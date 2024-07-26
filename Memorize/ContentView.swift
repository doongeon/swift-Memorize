//
//  ContentView.swift
//  Memorized//
//  Created by 나동건 on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    let fruits: Array<String> = ["🍋", "🍉","🍌","🍍"]
    
    var body: some View {
        HStack {
            
            ForEach(fruits.indices, id: \.self){
                index in CardView(content: fruits[index])
            }
        }
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            
            if(isFaceUp) {
                base
                    .foregroundColor(.white)
                base
                    .stroke(.orange, lineWidth: 2)
                Text(content).font(.largeTitle)
                
            }
            else {
                base
                    .foregroundColor(.orange)
            }
        }
        .padding()
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
