//
//  MemorizeModel.swift
//  Memorize
//
//  Created by 나동건 on 7/27/24.
//

import Foundation

struct MemorizeModel {
    let cards: Array<Card>
    
    func select() -> Void {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatch: Bool
        var content: String
    }
}
