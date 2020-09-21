//
//  Cardify.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/6/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var card: Card
    private let cornerRadius: CGFloat = 7.0
    private let edgeLineWidth: CGFloat = 2
    
    func body(content: Content) -> some View {
        ZStack {
            Group{
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(colorToFill)
                    .opacity(0.5)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeToFill)
                content
            }
        }
    }
    
    private var colorToFill: Color {
        if let matched = card.isMatched {
            if matched {
                return Color.green
            } else {
                return Color.gray
            }
        } else {
            if card.isSelected {
                return Color.orange
            } else {
                return Color.white
            }
        }
    }
    
    private var strokeToFill: Color {
        if let matched = card.isMatched {
            if matched {
                return Color.green
            } else {
                return Color.gray
            }
        } else {
            if card.isSelected {
                return Color.orange
            } else {
                return Color.black
            }
        }
    }
}

extension View {
    func cardify(card:Card) -> some View {
        self.modifier(Cardify(card:card))
    }
}
