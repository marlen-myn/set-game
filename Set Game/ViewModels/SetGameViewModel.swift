//
//  SetGameViewModel.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/13/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    
    @Published private var model: SetGame = SetGameViewModel.createSetGame()
    
    // creating the game with sending a closure as a parameter 
    private static func createSetGame() -> SetGame {
        SetGame() {
            CardContent(symbol: $0, color: $1, shading: $2, amount: $3)
        }
    }
    
    // MARK: - Intetns
    func serveCards(numberOfCardsToServe: Int) {
        model.serveCards(numberOfCardsToServe:numberOfCardsToServe)
    }
    
    func selectCard(card: Card){
        model.selectCards(card: card)
    }
    
    func startNewGame() {
        model = SetGameViewModel.createSetGame()
        model.serveCards(numberOfCardsToServe: 12)
    }
    
    // MARK: - Access to the Model
    var displayedCards: [Card] {
        model.displayedCards
    }
    
    var numberOfCardsleftInDeck: Int {
        model.deck.filter() { $0.isServed == false }.count
    }
    
    var isGameFinished: Bool {
        model.isGameFinished
    }
    
    var numberOfSets: Int {
        model.numberOfSetsMatched
    }
    
    var score: Int {
        model.score
    }
}
