//
//  ContentView.swift
//  MotivationQuotes
//
//  Created by Kristina Yaroshenko on 22.04.2025.
//

import SwiftUI

struct Quote: Codable, Identifiable, Equatable {
    var id: String { q + a }  // unique ID from quote + author
    let q: String             // quote text
    let a: String             // author
}

struct ContentView: View {
    @State private var currentQuote: Quote?
    @State private var favorites: [Quote] = []

    let favoritesKey="savedQuotes"
    
    func saveFavorites() {
        if let encoded=try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    func loadFavorites() {
        if let savedData=UserDefaults.standard.data(forKey: favoritesKey) {
            let decoded=try? JSONDecoder().decode([Quote].self, from: savedData){
                favorites=decoded
            }
        }
    }

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            NavigationView {
                VStack(spacing: 30) {
                    if let quote = currentQuote {
                        VStack(spacing: 10) {
                            Text("\"\(quote.q)\"")
                                .font(.title2)
                                .multilineTextAlignment(.center)
                                .padding()
                            
                            Text("- \(quote.a)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("Tap the button to get a motivational quote!")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Button(action: {
                        fetchQuote()
                    }) {
                        Text("New Quote")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .foregroundColor(Color(.systemBackground))
                            .cornerRadius(10)
                    }
                    
                    if let quote = currentQuote {
                        Button(action: {
                            if !favorites.contains(quote) {
                                favorites.append(quote)
                            }
                        }) {
                            Text("❤️ Save to Favorites"){
                                if !favorites.contains(where: {$0.text==quote.text}){
                                    favorites.append(quote)
                                    saveFavorites()
                                }
                            }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink("View Favorites", destination: FavoritesView(favorites: favorites))
                        .padding(.top, 30)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("Motivation App")
                .onAppear {
                    fetchQuote()
                    loadFavorites()
                }
            }
        }
    }
    
    func fetchQuote() {
        guard let url = URL(string: "https://zenquotes.io/api/random") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([Quote].self, from: data),
                   let firstQuote = decoded.first {
                    DispatchQueue.main.async {
                        currentQuote = firstQuote
                    }
                }
            } else if let error = error {
                print("Error fetching quote: \(error.localizedDescription)")
            }
        }.resume()
    }
}
