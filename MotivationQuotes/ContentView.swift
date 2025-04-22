//
//  ContentView.swift
//  MotivationQuotes
//
//  Created by Kristina Yaroshenko on 22.04.2025.
//

import SwiftUI

struct Quote: Codable, Identifiable, Equatable {
    var id: String { q + a }  // Unique ID
    let q: String             // Quote text
    let a: String             // Author

    var text: String { q }
    var author: String { a }
}

struct ContentView: View {
    @State private var currentQuote: Quote?
    @State private var favorites: [Quote] = []
    @State private var showShareSheet=false
    
    @AppStorage("fontSize") var fontSize: Double = 18
    @AppStorage("fontName") var fontName: String = "System"

    let favoritesKey="savedQuotes"
    
    func saveFavorites() {
        if let encoded=try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: favoritesKey) {
            if let decoded = try? JSONDecoder().decode([Quote].self, from: savedData) {
                favorites = decoded
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
                                .font(fontName == "System" ? .system(size: fontSize) : .custom(fontName, size: fontSize))
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
                        fetchQuotes()
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
                            if !favorites.contains(where: { $0.text == quote.text }) {
                                favorites.append(quote)
                                saveFavorites()
                            }
                        }) {
                            Text("❤️ Save to Favorites")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink("View Favorites", destination: FavoritesView(favorites: favorites))
                        .padding(.top, 30)
                    
                    NavigationLink("Settings", destination: SettingsView())

                    Spacer()
                    
                    if currentQuote != nil {
                        Button("Share"){
                            showShareSheet = true
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(Color(.systemBackground))
                        .cornerRadius(10)
                    }
                }
                .padding()
                .navigationTitle("Motivation App")
                .onAppear {
                    fetchQuotes()
                    loadFavorites()
                }
            }
            
            .sheet(isPresented: $showShareSheet) {
                if let quote = currentQuote {
                    let quoteText = "\"\(quote.text)\" — \(quote.author ?? "Unknown")"
                    ActivityView(activityItems: [quoteText])
                }
            }
        }
    }
    
    func fetchQuotes() {
        guard let url = URL(string: "https://zenquotes.io/api/random") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let decoded = try JSONDecoder().decode([Quote].self, from: data)
                    DispatchQueue.main.async {
                        // Only one quote returned at a time
                        self.currentQuote = decoded.first
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else if let error = error {
                print("Network error:", error)
            }
        }.resume()
    }
}
