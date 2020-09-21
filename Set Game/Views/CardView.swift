//
//  CardView.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/13/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var body: some View {
        GeometryReader { geometry in
            self.buildShape(size: geometry.size)
                .cardify(card:card)
        }
    }
    
    @ViewBuilder
    private func buildShape(size: CGSize) -> some View {
        let width = size.width * shapeWidthRatio
        let height = size.height * shapeHeightRatio
        let shape = createShape()
        
        VStack(spacing: self.shapeSpacing(for: size.height)) {
            ForEach(0..<card.content.amount, id: \.self) { index in
                shape
                    .frame(width: width, height: height)
            }
        }
    }
    
    // creating and filling the shape
    private func createShape() -> some View {
        var shape : AnyShape
        
        switch card.content.symbol {
        case .Capsule:
            shape =  AnyShape(Ellipse())
        case .Diamond:
            shape =  AnyShape(Diamond())
        case .Squiggle:
            shape =  AnyShape(Squiggle())
        }
        
        return ZStack {
            shape
                .fill(Color.white)
            shape
                .fill(shapeColor)
                .shading(card.content.shading, card.content.color)
            shape
                .stroke(shapeColor)
        }
    }
    
    private var shapeColor: Color {
        switch(card.content.color) {
        case .Blue:
            return Color.blue
        case .Green:
            return Color.green
        case .Red:
            return Color.red
        }
    }
    
    // MARK: - Constants
    func shapeSpacing(for cardHeight: CGFloat) -> CGFloat { return cardHeight / 10 }
    private let shapeWidthRatio: CGFloat = 0.85
    private let shapeHeightRatio: CGFloat = 0.2
}
