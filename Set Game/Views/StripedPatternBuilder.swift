//
//  StripedPatternBuilder.swift
//  Set Game
//
//  Created by Valerie 👩🏼‍💻 on 14/07/2020.
//

import SwiftUI

struct StripedPatternBuilder: ViewModifier {
    var shadingType: CardShading
    var color: CardColor
    
    func body(content: Content) -> some View {
        Group {
            switch shadingType {
            case .Solid:
                ZStack {
                    content.opacity(0)
                    Color.clear.mask(content)
                }
            case .Open:
                content
            case .Striped:
                ZStack {
                    content.opacity(0)
                    StripedPattern(stripeWidth: stripeWidth, interval: interval)
                        .stroke(color.color)
                        .mask(content)
                }
            }
        }
    }
    
    // MARK: - Drawing Constrains
    var stripeWidth = 2
    var interval = 4
}

extension View {
    func shading(_ shadingType: CardShading, _ color: CardColor) -> some View {
        self.modifier(StripedPatternBuilder(shadingType: shadingType, color: color))
    }
}


struct StripedPattern: Shape {
    var stripeWidth: Int
    var interval: Int
    
    func path(in rect: CGRect) -> Path {
        let numberOfStripes = Int(rect.width) / stripeWidth
        
        var path = Path()
        path.move(to: rect.origin)
        
        for index in 0...numberOfStripes {
            if index % interval == 0 {
                path.addRect(CGRect(
                                x: CGFloat(index * stripeWidth),
                                y: 0,
                                width: CGFloat(stripeWidth),
                                height: rect.height)
                )
            }
        }
        return path
    }
}
