//
//  FlyingNumber.swift
//  Memorize
//
//  Created by 나동건 on 8/22/24.
//

import SwiftUI

struct FlyingNumber: View, Animatable {
    var number: Int
    
    @State var offset: CGFloat = 0
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue}
    }
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always(includingZero: false)))
                .offset(CGSize(width: 0, height: offset))
                .font(.title3)
                .bold()
                .foregroundStyle(number > 0 ? .green : .red)
                .opacity(offset == 0 ? 1: 0)
                .onAppear() {
                    withAnimation {
                        offset = number > 0 ? -200 : 200
                    }
                }
                .animation(.easeIn(duration: 1), value: offset)
                .onDisappear() {
                    offset = 0
                }
        }
    }
}

#Preview {
    FlyingNumber(number: -1)
}
