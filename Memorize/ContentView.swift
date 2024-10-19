//
//  ContentView.swift
//  Memorize
//
//  Created by Boris Ryavkin on 19/10/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack{
            let emojis: [String] = ["🥸","😎", "😍", "😇"]
            ForEach(0..<4, id: \.self) {index in
                CardView(content: emojis[index])
            }
        }
        .foregroundStyle(.orange)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View{
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            } else {
                base.fill()

            }
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
