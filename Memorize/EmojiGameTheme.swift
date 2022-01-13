//
//  GameTheme.swift
//  Memorize
//
//  Created by Matthew Oyales on 1/10/22.
//

import Foundation
import SwiftUI

struct EmojiGameTheme {
    // Emoji/Theme sets based on given themes:
    // 1. Travel
    // 2. Food
    // 3. Nature
    // 4. People
    // 5. Flags
    // 6. Memes
    private static let travelSet = ["🚗", "🚌", "🚎", "🏎", "🚑", "🚜", "🚍", "🚞", "✈️", "🚁", "🛩", "⛵️", "🚢", "🚡", "🛰", "🚊", "🛴", "🦼", "🛻", "⚓️", "🚦", "🎢", "🛺", "🚓"]
    private static let foodSet = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑", "🥭", "🍍", "🥥", "🥝", "🍅", "🥑", "🥦", "🌶", "🌽", "🫑", "🥕"]
    private static let natureSet = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🦁", "🐔", "🐝", "🦂", "🐙", "🐠", "🦚", "🌵", "🌲", "🍀", "🌷", "🌼", "🌻", "🌹"]
    private static let peopleSet = ["👩‍🦰", "👨", "👷‍♂️", "👵", "👨‍🎓", "👨‍🍳", "👨‍🏫", "👨‍🚀", "🙋", "🙎‍♂️", "🙍‍♀️", "🧟‍♀️", "🧝‍♀️", "🧑‍💻", "🧔‍♀️", "👩‍✈️", "👩‍🚀", "🥷", "🧞‍♂️", "🧜", "🧛‍♀️", "👱‍♀️", "👶", "🧒"]
    private static let flagSet = ["🇺🇸", "🇨🇦", "🇲🇽", "🇯🇵", "🇬🇷", "🇮🇪", "🇬🇧", "🇷🇺", "🇵🇹", "🇪🇸", "🇵🇭", "🇰🇷", "🇳🇴", "🇮🇳", "🇫🇮", "🇿🇦", "🏳️‍🌈", "🇧🇪", "🇨🇺", "🇮🇱", "🇵🇷", "🇨🇿", "🇫🇷", "🇩🇪"]
    private static let memeSet = ["🅱️", "🤔", "🍆", "🔥", "😂", "😈", "🤡", "🖕", "👀", "🤷‍♂️", "👁", "👄", "🦑", "💦", "🤯", "🥸", "🤢", "🤮", "🧐", "😱", "💀", "👽", "🥲", "😳"]
    
    private static let randPairRange = Int.random(in: 4..<13)
    
    private static let themesList: Array<Theme> = [
        Theme(themeName: "Travel", emojiSet: travelSet, numPairs: randPairRange, themeColor: "red"),
        Theme(themeName: "Food", emojiSet: foodSet, numPairs: randPairRange, themeColor: "orange"),
        Theme(themeName: "Nature", emojiSet: natureSet, numPairs: randPairRange, themeColor: "green"),
        Theme(themeName: "People", emojiSet: peopleSet, numPairs: randPairRange, themeColor: "yellow"),
        Theme(themeName: "Flags", emojiSet: flagSet, numPairs: randPairRange, themeColor: "blue"),
        Theme(themeName: "Memes", emojiSet: memeSet, numPairs: randPairRange, themeColor: "purple"),
    ]
    
    private(set) var themeChoice: Theme
    private(set) var themeTitle: String
    private(set) var themeSet: Array<String>
    private(set) var color: String
    
    init() {
        themeChoice = EmojiGameTheme.themesList[Int.random(in: 0..<6)]
        
        themeTitle = themeChoice.themeName
        themeSet = themeChoice.emojiSet
        color = themeChoice.themeColor
    }
    
    struct Theme {
        var themeName: String
        var emojiSet: Array<String>
        var numPairs: Int
        var themeColor: String
    }
}

