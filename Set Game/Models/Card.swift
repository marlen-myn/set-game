//
//  Card.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/13/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import Foundation

struct Card: Identifiable, Equatable {
    
    var id: Int
    var content : CardContent
    var isServed : Bool = false
    var isSelected: Bool = false
    var isMatched: Bool?
    var isCurrentlyDisplayed = false
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.id == rhs.id
    }
    
    var isCardMatched: Bool {
        if isMatched != nil && isMatched == true {
            return true
        } else {
            return false
        }
    }
}
