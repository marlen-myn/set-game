//
//  AnyShape.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/13/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct AnyShape: Shape {
    private let path: (CGRect) -> Path
    
    init<S: Shape>(_ wrapped: S) {
        path = {
            rect in
            wrapped.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        path(rect)
    }
}
