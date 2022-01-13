//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Matthew Oyales on 1/6/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
        
    var body: some View {
        VStack {
            Text("Memorize!")
                .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility1/*@END_MENU_TOKEN@*/)
            topText
                .padding(.horizontal)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                cardView(for: card)
            }
            .foregroundColor(game.themeCardColor)
            .padding(.horizontal)
            resetButton
        }
    }
    
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }
    
    private var resetButton: some View {
        Button(action: {
            game.restart()
        }) {
            VStack {
                Image(systemName: "restart.circle")
                    .font(.largeTitle)
                Text("Restart Game")
            }
        }
    }
    
    private var topText: some View {
        HStack {
            VStack {
                Text("Theme:")
                Text("\(game.displayTitle)")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            VStack {
                Text("Score:")
                Text("\(game.points)")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            VStack {
                Text("Pairs:")
                Text("\(game.numPairs)")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}


struct CardView: View {
    let card: EmojiMemoryGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                        .padding(5)
                        .opacity(0.5)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
//        ContentView(game: game)
//            .preferredColorScheme(.light)
    }
}
