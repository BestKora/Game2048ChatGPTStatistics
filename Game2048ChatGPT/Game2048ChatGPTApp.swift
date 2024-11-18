//
//  Game2048ChatGPTApp.swift
//  Game2048ChatGPT
//
//  Created by Tatiana Kornilova on 25.10.2024.
//

import SwiftUI

@main
struct Game2048ChatGPTApp: App {
    @State var game = GameViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: game)
           // GameView(viewModel: game)
                .modelContainer(for: [TreeSearch.self, MonterCarloNew.self])
        }
    }
}
