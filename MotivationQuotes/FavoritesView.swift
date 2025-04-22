//
//  FavoritesView.swift
//  MotivationQuotes
//
//  Created by Kristina Yaroshenko on 22.04.2025.
//

import SwiftUI

struct FavoritesView: View {
    let favorites: [Quote]

    var body: some View {
        List(favorites) { quote in
            VStack(alignment: .leading, spacing: 6) {
                Text("\"\(quote.q)\"")
                    .font(.body)
                Text("- \(quote.a)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Favorite Quotes")
    }
}
