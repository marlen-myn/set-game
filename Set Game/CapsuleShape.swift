//
//  CapsuleShape.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/14/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct CapsuleShape: View {
    var card: Card
    
    var body: some View {
        self.body(color: card.content.color.color, shading: card.content.shading)
    }
    
    @ViewBuilder
    private func body(color: Color, shading: CardShading) -> some View {
        VStack {
            ForEach(0..<card.content.amount) {_ in
                if shading == CardShading.Solid {
                    Capsule()
                        .fill(color)
                } else if shading == CardShading.Open {
                    Capsule()
                        .stroke(color, lineWidth: 2)
                } else if shading == CardShading.Striped {
                    Capsule()
                        .fill(color)
                        .opacity(0.3)
                }
            }
            .aspectRatio(2/1, contentMode: .fit)
            .padding(10)
        }
    }
}
