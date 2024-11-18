//
//  HomeView.swift
//  SwidtData Airport
//
//  Created by Tatiana Kornilova on 27.02.2022.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    var viewModel: GameViewModel
   
    var body: some View {
        TabView {
            GameView(viewModel: viewModel)
                .tabItem{
                    Label("Game", systemImage: "playstation.logo")
                    Text("Game")
                }
            MonteCarloView()
                .tabItem{
                    Label("Monte Carlo", systemImage: "cube.transparent")
                    Text("Monte Carlo")
                }
            ChartViewNew()
                .tabItem{
                    Label("Monte Chart", systemImage: "chart.bar.xaxis")
                    Text("Monte Chart")
                }
            TreeSearchView()
                .tabItem{
                    Label("Expectimax", systemImage: "cube.transparent")
                    Text("Tree Search")
                }
            ChartTreeView()
                .tabItem{
                    Label("Expect Chart", systemImage: "chart.bar.xaxis")
                    Text("Tree Chart")
                }
        }
    }
}

#Preview {
    HomeView(viewModel: GameViewModel())
        .modelContainer(previewContainer)
}
