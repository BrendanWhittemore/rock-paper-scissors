//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Brendan Whittemore on 4/6/25.
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock = "🪨"
    case paper = "📄"
    case scissors = "✂️"
}

struct ContentView: View {
    @State private var computerMove = Move.allCases.randomElement()!
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    
    private let maxRounds = 10
    @State private var roundCount = 1
    @State private var gameOver = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .animation(.default)
                
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Computer Move")
                        .font(.headline)
                    
                    Text("\(computerMove.rawValue)")
                        .font(.largeTitle)
                        .animation(.default)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                VStack(spacing: 15) {
                    Text("You Should")
                        .font(.headline)
                    
                    Text("\(shouldWin ? "Win" : "Lose")")
                        .font(.title)
                        .animation(.default)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                HStack {
                    ForEach(Move.allCases, id: \.self) { move in
                        Button {
                            moveTapped(move)
                        } label: {
                            Text("\(move.rawValue)")
                                .font(.largeTitle)
                                .padding()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding()
                    }
                }
                
                Spacer()
                Spacer()
            }
            .navigationTitle("Rock Paper Scissors")
            .padding()
            .alert("Thanks for playing!", isPresented: $gameOver) {
                Button("New Game", action: resetGame)
            } message: {
                Text("Your final score was \(score)")
            }
        }
    }
    
    func moveTapped(_ playerMove: Move) {
        let wonRound: Bool?
        
        switch computerMove {
        case .rock:
            wonRound = shouldWin ? playerMove == .paper : playerMove == .scissors
        case .paper:
            wonRound = shouldWin ? playerMove == .scissors : playerMove == .rock
        case .scissors:
            wonRound = shouldWin ? playerMove == .rock : playerMove == .paper
        }
        
        score = wonRound! ? score + 1 : max(0, score - 1)
        
        if roundCount == maxRounds {
            gameOver = true
        } else {
            computerMove = Move.allCases.randomElement()!
            shouldWin.toggle()
            roundCount += 1
        }
    }
    
    func resetGame() {
        score = 0
        roundCount = 1
        computerMove = Move.allCases.randomElement()!
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
