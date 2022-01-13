//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Matthew Oyales on 1/9/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static func createMemoryGame(_ selectedTheme: Array<String>) -> MemoryGame<String> {
        let randRange = Int.random(in: 4..<25)
        
        return MemoryGame<String>(numberOfPairsOfCards: randRange) { pairIndex in
            selectedTheme[pairIndex]
        }
    }
    
    @Published private var game = createMemoryGame(emojis.shuffled())
    
    private static var theme: EmojiGameTheme = EmojiGameTheme()
    private static var emojis = theme.themeSet
    private var displayColor = theme.color
    
    // Variables that the View will need
    var displayTitle = theme.themeTitle
    var cards: Array<Card> { game.cards }
    var points: Int { game.points }
    var numPairs: Int { game.pairs }
    var themeCardColor: Color {
        switch displayColor {
            case "red": return Color(red: 0.93, green: 0.26, blue: 0.11)
            case "orange": return Color(red: 0.95, green: 0.49, blue: 0.04)
            case "green": return Color(red: 0.08, green: 0.44, blue:0.06)
            case "yellow": return Color(red: 1, green: 0.98, blue:0.08)
            case "blue": return Color(red: 0.0, green: 0.0, blue: 1.0)
            case "purple": return Color(red: 0.53, green: 0, blue: 1)
            default: return Color(red: 0.71, green: 0.71, blue: 0.72)
        }
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        game.choose(card)
    }
    
    func restart() {
        print("Game Restart!")
        EmojiMemoryGame.theme = EmojiGameTheme()
        EmojiMemoryGame.emojis = EmojiMemoryGame.theme.themeSet
        game = EmojiMemoryGame.createMemoryGame(EmojiMemoryGame.emojis.shuffled())
        displayTitle = EmojiMemoryGame.theme.themeTitle
        displayColor = EmojiMemoryGame.theme.color
    }
}
