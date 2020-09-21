//
//  CardContent.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/13/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import Foundation
import SwiftUI

struct CardContent {
    
    var symbol: CardSymbol
    var color: CardColor
    var shading: CardShading
    var amount: Int
    
    init (symbol: CardSymbol, color:CardColor, shading: CardShading, amount: Int) {
        self.symbol = symbol
        self.color = color
        self.shading = shading
        self.amount = amount
    }
    
}

enum CardSymbol: CaseIterable {
    case Diamond
    case Squiggle
    case Capsule
}

enum CardColor: CaseIterable {
    case Red
    case Green
    case Blue
    
    var color: Color {
        switch self {
        case .Red:
            return Color.red
        case .Green:
            return Color.green
        case .Blue:
            return Color.blue
        }
    }
}

enum CardShading: CaseIterable {
    case Solid
    case Open
    case Striped
}

enum CardNumber: Int, CaseIterable {
    case One = 1
    case Two
    case Three
}
