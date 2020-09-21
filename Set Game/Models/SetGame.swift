//
//  SetGame.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/13/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
///

import Foundation

struct SetGame {
    private(set) var deck: [Card]
    private var cardIndexToServe = 0
    private(set) var numberOfSetsMatched = 0
    private(set) var score = 0
    
    // currently displayed cards
    var displayedCards: [Card] {
        deck.filter() { $0.isCurrentlyDisplayed }
    }
    // currently selected cards
    private var selectedCards: [Card] {
        deck.filter() { $0.isSelected }
    }
    
    private(set) var isMatched : Bool = false
    
    var isGameFinished : Bool {
        numberOfSetsMatched == 27
    }
    
    //initialization, creating a deck of cards
    init(createContent: (CardSymbol, CardColor, CardShading, Int) -> CardContent) {
        deck = [Card]()
        for number in CardNumber.allCases {
            for symbol in CardSymbol.allCases {
                for color in CardColor.allCases{
                    for shading in CardShading.allCases {
                        let content = createContent(symbol, color, shading, number.rawValue)
                        deck.append(Card(id:deck.count, content: content))
                    }
                }
            }
        }
        deck.shuffle() // shuffling the deck
    }
    
    // serving and displaying the cards
    mutating func serveCards(numberOfCardsToServe: Int) {
        if isMatched {
            isMatched.toggle()
            self.throwingAwayMatchedCards()
        }
        if cardIndexToServe < 80 {
            for cardIndex in cardIndexToServe..<cardIndexToServe + numberOfCardsToServe {
                deck[cardIndex].isServed = true
                deck[cardIndex].isCurrentlyDisplayed = true
            }
            cardIndexToServe += numberOfCardsToServe
        }
    }
    
    private mutating func throwingAwayMatchedCards() {
        for card in selectedCards {
            if let cardIndex = deck.firstIndex(of: card) {
                deck[cardIndex].isCurrentlyDisplayed = false
            }
        }
    }
    
    // unMatch cards, set to nil
    private mutating func unMatchCards() {
        for card in selectedCards {
            if let cardIndex = deck.firstIndex(of: card) {
                deck[cardIndex].isMatched = nil
            }
        }
    }
    
    // unselect cards, set to false
    private mutating func unSelectCards() {
        for card in selectedCards {
            if let cardIndex = deck.firstIndex(of: card) {
                deck[cardIndex].isSelected = false
            }
        }
    }
    
    mutating func selectCards(card: Card) {
        if isMatched {
            isMatched.toggle()
            self.throwingAwayMatchedCards()
            self.serveCards(numberOfCardsToServe: 3)
        }
        if selectedCards.count > 2 {
            self.unMatchCards()
            self.unSelectCards()
        }
        if let cardIndex = deck.firstIndex(matching: card){
            deck[cardIndex].isSelected.toggle()
        }
        if selectedCards.count == 3 {
            isMatched = isSetMatched(selectedCards[0], selectedCards[1], selectedCards[2])
            if isMatched {
                numberOfSetsMatched+=1
                score+=1
            }
            markCards(status: isMatched)
        }
    }
    
    // marking cards as matched or not
    private mutating func markCards(status: Bool) {
        for card in selectedCards {
            if let cardIndex = deck.firstIndex(of: card) {
                deck[cardIndex].isMatched = status
            }
        }
    }
    
    private func isSetMatched(_ a: Card, _ b: Card, _ c: Card) -> Bool {
        return propertiesMatch(a.content.amount, b.content.amount, c.content.amount)
            && propertiesMatch(a.content.color, b.content.color, c.content.color)
            && propertiesMatch(a.content.symbol, b.content.symbol, c.content.symbol)
            && propertiesMatch(a.content.shading, b.content.shading, c.content.shading)
    }
    
    private func propertiesMatch<CardProperty: Equatable>(_ a: CardProperty, _ b: CardProperty, _ c: CardProperty) -> Bool {
        return (a == b && a == c && b == c) || (a != b && a != c && b != c)
    }
    
}
