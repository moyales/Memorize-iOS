//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Matthew Oyales on 1/6/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private var cardCount: Int { viewModel.cards.count }
    private func minGridNum(_ count: Int) -> CGFloat {
        if count <= 8 {
            return CGFloat(100)
        } else if count <= 16 {
            return CGFloat(75)
        } else if count <= 24 {
            return CGFloat(60)
        } else {
            return CGFloat(50)
        }
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .dynamicTypeSize(/*@START_MENU_TOKEN@*/.accessibility1/*@END_MENU_TOKEN@*/)
            topText
                .padding(.horizontal)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: minGridNum(cardCount)))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.themeCardColor)
            .padding(.horizontal)
            Button(action: {
                viewModel.restart()
            }) {
                VStack {
                    Image(systemName: "restart.circle")
                        .font(.largeTitle)
                    Text("Restart Game")
                }
            }
        }
    }
    
    var topText: some View {
        HStack {
            VStack {
                Text("Theme:")
                Text("\(viewModel.displayTitle)")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            VStack {
                Text("Score:")
                Text("\(viewModel.points)")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            VStack {
                Text("Pairs:")
                Text("\(viewModel.numPairs)")
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            // let = constant; var = variable
            let shape = RoundedRectangle(cornerRadius: 15.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            .preferredColorScheme(.dark)
//        ContentView(viewModel: game)
//            .preferredColorScheme(.light)
    }
}
