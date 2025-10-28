//
//  ContentView.swift
//  Memorize
//
//  Created by Boris Ryavkin on 19/10/2024.
//

import SwiftUI

struct ContentView: View {
    struct Card: Identifiable, Equatable {
        let id: UUID = UUID()
        let content: String
        var isFaceUp: Bool = false
        var isMatched: Bool = false
    }

    @State var cards: [Card] = []
    @State var currentTheme: [String] = faces
    @State private var isResolvingMismatch: Bool = false
    var body: some View {
        VStack{
            Text("Memozie!")
                .font(.largeTitle)
            ScrollView{
                cardGrid}
            Spacer()
            Theme
        }
        .padding()
        .onAppear { newGame(with: currentTheme) }
    }
    
    var cardGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(cards) { card in
                CardView(content: card.content, isFaceUp: card.isFaceUp, isMatched: card.isMatched)
                    .aspectRatio( 2/3, contentMode: .fit)
                    .onTapGesture { handleTap(on: card) }
            }
        }
        .foregroundStyle(.red)
    }
    
    var Theme: some View {
        HStack{
            Spacer()
            themeButton(system: "face.smiling", set: faces)
            Spacer()
            themeButton(system: "dog.fill", set: animals)
            Spacer()
            themeButton(system: "sparkles", set: things)
            Spacer()
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func themeButton(system: String, set: [String]) -> some View {
        Button(action: {
            currentTheme = set.shuffled()
            newGame(with: currentTheme)
        }, label: {
            Image(systemName: system)
        })
    }

    // MARK: - Game Logic
    private func newGame(with theme: [String]) {
        let pairCount = min(8, theme.count) // up to 8 pairs
        let chosen = Array(theme.prefix(pairCount))
        var newCards: [Card] = []
        for symbol in chosen {
            newCards.append(Card(content: symbol))
            newCards.append(Card(content: symbol))
        }
        cards = newCards.shuffled()
        isResolvingMismatch = false
    }

    private func handleTap(on tapped: Card) {
        guard let index = cards.firstIndex(of: tapped) else { return }
        guard !cards[index].isMatched, !cards[index].isFaceUp else { return }
        guard !isResolvingMismatch else { return }

        let faceUpIndices = cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }

        if faceUpIndices.count < 2 {
            cards[index].isFaceUp = true
        }

        let newFaceUpIndices = cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }
        if newFaceUpIndices.count == 2 {
            let first = newFaceUpIndices[0]
            let second = newFaceUpIndices[1]
            if cards[first].content == cards[second].content {
                cards[first].isMatched = true
                cards[second].isMatched = true
            } else {
                isResolvingMismatch = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    cards[first].isFaceUp = false
                    cards[second].isFaceUp = false
                    isResolvingMismatch = false
                }
            }
        }
    }
}

struct CardView: View {
    let content: String
    let isFaceUp: Bool
    let isMatched: Bool
    
    var body: some View{
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp || isMatched {
                Group {
                    base.fill(.white)
                    base.strokeBorder(.red, lineWidth: 2)
                    Text(content)
                        .font(.largeTitle)
                        .foregroundStyle(.tint)
                }
            } else {
                base.fill().foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    ContentView()
}
