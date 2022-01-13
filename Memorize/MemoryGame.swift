//
//  Model for the Application
//  THIS DOES NOT DO UI - IT IS UI-INDEPENDENT
//
//  MemoryGame.swift
//  Memorize
//
//  Created by Matthew Oyales on 1/9/22.
//

import Foundation
import SwiftUI

// I kind of care about the type by stating "where"
struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var seen: Set<Card.ID>
    private(set) var points: Int
    private(set) var pairs: Int
    private(set) var time: Date
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        let pointsGained = 20.0
        let pointsLost = 10.0
        var timeFactor: Double { time.timeIntervalSinceNow * -1 }
        let pointsEarned = Int(max(3-timeFactor, 1.0) * pointsGained)
        let pointsDeducted = Int(max(3-timeFactor, 1.0) * pointsLost)
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                seen.insert(cards[potentialMatchIndex].id)
                
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    
                    print(timeFactor)
                    print(pointsEarned)
                    points += pointsEarned
                    pairs -= 1
                } else if seen.contains(cards[chosenIndex].id) {
                    print(timeFactor)
                    print(pointsDeducted)
                    points -= pointsDeducted
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                time = Date()
            }
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = []
        seen = []
        points = 0
        pairs = 0
        time = Date()
        
        // add number of pairs of cards * 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            
            cards.append(Card(content: content, id:pairIndex*2))
            cards.append(Card(content: content, id:pairIndex*2+1))
            pairs += 1
        }
        cards = cards.shuffled()
    }
    
    // Full Name: MemoryGame.Card
    // Limit the scope to just the memory game.
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent    // "Don't Care", or generic
        var id: Int
    }
}

// This code is part of an Array
extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}
