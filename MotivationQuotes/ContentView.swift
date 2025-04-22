//
//  ContentView.swift
//  MotivationQuotes
//
//  Created by Kristina Yaroshenko on 22.04.2025.
//

import SwiftUI

struct ContentView: View {
    //List of quotes
    let quotes: [String] = [
        "The only way to do great work is to love what you do.",
        "Your time is limited, don't waste it living someone else's life.",
        "The future belongs to those who believe in the power of imagination.",
        "Your potential is unlimited. There is nothing that can stop you from achieving your dreams.",
        ]
    
    //Current quote state
    @State private var currentQuote = "Tap the button for a motivational quote!"
    
    var body: some View {
        VStack(spacing:30) {
            Text(currentQuote)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: {
                currentQuote=quotes.randomElement() ?? "No quotes found!"
            }) {
                Text("New Quote")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
