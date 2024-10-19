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
            CardView()
            CardView()
            CardView(isFaceUp: false)
            CardView()
        }
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = true
    
    var body: some View{
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2)
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
        }
    }
}

#Preview {
    ContentView()
}
