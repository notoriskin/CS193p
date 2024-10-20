//
//  ContentView.swift
//  Memorize
//
//  Created by Boris Ryavkin on 19/10/2024.
//

import SwiftUI

struct ContentView: View {
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            Text("Memozie!")
                .font(.largeTitle)
            ScrollView{
                cards}
            Spacer()
            Theme
        }
        .padding()
    }
    var Theme: some View {
        HStack{
            Spacer()
            cardRemover
            Spacer()
            cardRemover
            Spacer()
            cardAdder
            Spacer()
        }

        .imageScale(.large)
        .font(.largeTitle)
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]){
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index])
                    .aspectRatio( 2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String ) -> some View {
        Button(action:{
                cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
        
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    
    var body: some View{
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            print("you're tapped")
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
