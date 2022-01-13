//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Matthew Oyales on 1/6/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
