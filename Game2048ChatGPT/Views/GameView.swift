//
//  GameView.swift
//  Game2048ChatGPT
//
//  Created by Tatiana Kornilova on 21.08.2024.
//

import SwiftUI

struct GameView: View {
  //  @State private var viewModel = GameViewModel()
    @Bindable var viewModel: GameViewModel
    let tileSize: CGFloat = 80
    let padding: CGFloat = 8
    
    @State var isAIPlaying = false
    @State var selectedAlgorithm = Algorithm.Expectimax

    @State var timer = Timer.publish(every: 0.45, on: .main, in: .common).autoconnect()
    @Environment(\.modelContext) private var сontext

    var body: some View {
        VStack(spacing: 0) {
            WinnerBlock(settings: $viewModel.setting)
                .padding(.horizontal)
            score
            AI
            gameOver
            //  Grid
            GridView(tiles: viewModel.tiles, tileSize: tileSize, padding: padding, optimalDirection: viewModel.optimalDirection, isShowingOptimalDirection: viewModel.isShowingOptimalDirection)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                          withAnimation {
                                handleSwipe(value: value)
                          }
                        }
                )
            resetHint
            constantsInfo
        }
      .onReceive(timer){ value in
          if isAIPlaying {
              if !viewModel.isGameOver {
                  if selectedAlgorithm == Algorithm.MonteCarloAsync {
                      viewModel.monteCarloAsyncAIMove()
                  } else if selectedAlgorithm == Algorithm.Expectimax1 {
                      viewModel.expectimaxAsyncAIMove()
                  } else {
                      viewModel.executeAIMove()
                  }
              } else {
                  isAIPlaying  = false
                  writeDB()
              }
          }
        }
      .onChange(of: selectedAlgorithm) { oldValue,newValue in
                  // Recreate the timer with the new interval
          if newValue == Algorithm.MonteCarlo {
              timer = Timer.publish(every: 0.65, on: .main, in: .common).autoconnect()
          } else {
              timer = Timer.publish(every: 0.45, on: .main, in: .common).autoconnect()
          }
        }
    }
    
    private var score: some View {
        // Score Display
        HStack {
            // Score Display
            Text("Score: \(viewModel.score)")
                .monospacedDigit()
                .contentTransition(.numericText(value: Double(viewModel.score)))
                .transaction { t in
                    t.animation = .default
                }
            Spacer()
            Text("Best: 165 080")
        }
        .font(.title2)
        .foregroundColor(.accentColor)
        .padding([.top, .leading,.trailing] )
       // .padding()
    }
    
    private var AI: some View {
       //  AI information
        HStack {
            // Algorithm Display
           AlgorithmMenu(algorithm:$selectedAlgorithm)
            .onChange(of: selectedAlgorithm) {
                viewModel.setAlgorithm(selectedAlgorithm)
            } // onChange
            Spacer()
           
            // AI
               Button(action: {
                   isAIPlaying.toggle()
            }) {
                HStack {
                    Image(systemName: isAIPlaying ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text(isAIPlaying ? "AI Stop" : "AI Play")
                }
            }
        }
        .font(.title2)
        .foregroundColor(.accentColor)
        .padding()
    }
    
    private var gameOver: some View {
        // Game Over
        Text(viewModel.isGameOver  ? "Game Over": " ___ ")
                .font(.title2)
                .foregroundColor(viewModel.isGameOver  ? .red : .clear)
                .padding([.bottom, .leading, .trailing] )
    }
    
    private var resetHint: some View {
        HStack {
            // Reset Button
            Button(action: {
                withAnimation {
                    viewModel.resetGame()
                }
            }) {
                Text("Restart")
                    .font(.title2)
                    .padding()
            }
            
            Spacer()
            
            // Show Optimal
            Button(action: {
                viewModel.isShowingOptimalDirection.toggle()
            }) {
                HStack {
                    Image(systemName: viewModel.isShowingOptimalDirection ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 30, height: 30)
                    Text("Hint")
                }
            }
        }
        .font(.title2)
        .foregroundColor(.accentColor)
        .padding([.top, .trailing] )
    }
    private var constantsInfo: some View {
        // Constants Information display
        HStack {
            if selectedAlgorithm == Algorithm.MonteCarlo ||   selectedAlgorithm == Algorithm.MonteCarloAsync {
                VStack(alignment: .leading) {
                    HStack {
                        Text("N = \(String( Constants.numberSimilations ))")
                        Text("depth = \(String( Constants.deep )) ")
                        
                        Text("zeros = \(String( Constants.limitZeros))")
                        Text("weight = \(String( Constants.zerosWeightMC))")
                    }
                }
            } else  if selectedAlgorithm == Algorithm.Expectimax ||   selectedAlgorithm == Algorithm.Expectimax1{
                Text("zeroWeight = \(String( Constants.zerosWeight ))")
            }
            Spacer()
        }
        .font(.subheadline)
        .padding()
    }
    
    private func writeDB(){
        let grid = viewModel.tiles.map {$0.map{$0.value}}
        let maxTile = grid.flatMap { $0 }.max() ?? 2
        
        if selectedAlgorithm == Algorithm.MonteCarloAsync ||  selectedAlgorithm == Algorithm.MonteCarlo {
                сontext.insert(MonterCarloNew(algorithm:selectedAlgorithm.rawValue,time: Date.now,numberExperiments: Constants.numberSimilations, deep: Constants.deep, limitZeros: Constants.limitZeros, maxTile:  maxTile, score: viewModel.score, moves: 0,zerosWeightMC: Constants.zerosWeightMC))
            сontext.saveContext()
        } else {
            сontext.insert(TreeSearch(algorithm: selectedAlgorithm.rawValue, time: Date.now, fourEstimate: true, zeroWeight: Constants.zerosWeight, zerosBeginning : Constants.zerosBeginning ,maxTile:  maxTile, score: viewModel.score, moves: 0))
            сontext.saveContext()
        }
    }
    
    // Handle swipe gesture and trigger game actions
    private func handleSwipe(value: DragGesture.Value) {
        let threshold: CGFloat = 20
        let horizontalShift = value.translation.width
        let verticalShift = value.translation.height
        
            if abs(horizontalShift) > abs(verticalShift) {
                if horizontalShift > threshold {
                    viewModel.move(.right)
                } else if horizontalShift < -threshold {
                    viewModel.move(.left)
                }
            } else {
                if verticalShift > threshold {
                    viewModel.move(.down)
                } else if verticalShift < -threshold {
                    viewModel.move(.up)
                }
           }
    }
}

#Preview {
    GameView(viewModel: GameViewModel()) 
        .modelContainer(previewContainer)//.preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
