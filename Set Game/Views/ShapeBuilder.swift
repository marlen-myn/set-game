//
//  ShapeBuilder.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/15/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct ShapeBuilder<S:Shape> :View {
    let symbol: S
    let card: Card
    
    var body: some View {
        GeometryReader { geometry in
            self.createShapeContent(for: geometry.size)
        }.padding(5)
    }
    
    @ViewBuilder
    private func createShapeContent(for size: CGSize) -> some View {
        
        let width = size.width * shapeWidthRatio
        let height = size.height * shapeHeightRatio
        let shape = self.adjustShapeContent()
        
        VStack(spacing: self.shapeSpacing(for: size.height)) {
            ForEach(0..<card.content.amount, id: \.self) { index in
                shape
                    .frame(width: width, height: height)
            }
        }
    }
    
    private func adjustShapeContent() -> some View {
        return ZStack {
            self.symbol
                .fill(Color.white)
            self.symbol
                .fill(shapeColor)
                .opacity(shapeOpacity)
            self.symbol
                .stroke(shapeColor)
                .opacity(card.content.shading == .Open ? 1 : shapeOpacity)
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
    
    private var shapeOpacity: Double {
        switch(card.content.shading) {
        case .Open:
            return 0.0
        case .Solid:
            return 1.0
        case .Striped:
            return 0.5
        }
    }
    
    // MARK: - Constants
    func shapeSpacing(for cardHeight: CGFloat) -> CGFloat { return cardHeight / 10 }
    let shapeWidthRatio: CGFloat = 0.85
    let shapeHeightRatio: CGFloat = 0.2
}
