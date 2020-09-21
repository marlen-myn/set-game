//
//  SetGameView.swift
//  Set Game
//
//  Created by Marlen Mynzhassar on 9/13/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    
    // creating a random spot out of which cards fly in/out
    private var randomOffset: CGSize {
        let signs: [CGFloat] = [-1, 1]
        let size = UIScreen.main.bounds.size
        let width = (.random(in: 2 * 0..<size.width) + size.width) * signs.randomElement()!
        let height = (.random(in: 2 * 0..<size.height) + size.height) * signs.randomElement()!
        return CGSize(width: width, height: height)
    }
    
    var body: some View {
        VStack {
            // upper panel view
            HStack {
                Text("Sets: \(viewModel.numberOfSets)/27").padding(.trailing)
                Text("Score: \(viewModel.score)").padding()
                Text("Cards left: \(viewModel.numberOfCardsleftInDeck)").padding(.leading)
            }
            .padding(2)
            .animation(nil)
            
            Divider()
                .padding()
            
            VStack {
                // if game is finished
                if viewModel.isGameFinished {
                    Text("Congratulations!")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                } else {
                    // main content view
                    Grid(viewModel.displayedCards) { card in
                        CardView(card:card).onTapGesture {
                            withAnimation {
                                self.viewModel.selectCard(card: card)
                            }
                        }
                        .padding(7)
                        .transition(.offset(self.randomOffset))
                        // rotate if matched
                        .rotation3DEffect(Angle.degrees(card.isCardMatched ? 360 : 0), axis: (0,1,0))
                    }
                    .onAppear(perform: {
                        withAnimation(.easeInOut(duration: 2)) {
                            self.viewModel.startNewGame()
                        }
                    })
                }
            }
            
            Divider()
                .padding()
            
            // bottom panel view
            HStack {
                
                if !viewModel.isGameFinished {
                    Button(action:{
                        withAnimation(.easeInOut(duration: 0.75)) {
                            self.viewModel.serveCards(numberOfCardsToServe: 3)
                        }
                    }) {
                        HStack {
                            Text("Deal 3 More Cards")
                        }.padding(10.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 2.0)
                        )
                    }
                    .padding(.trailing)
                    .disabled(viewModel.numberOfCardsleftInDeck<1)
                }
                
                Button(action:{
                    withAnimation(.easeInOut(duration: 0.75)) {
                        viewModel.startNewGame() // creating a new game
                    }
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("New Game")
                    }.padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                }.padding(.leading)
                
            }
        }
    }
}

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        return SetGameView(viewModel: game)
    }
}
