//
//  GridPlaceholderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 29/4/24.
//

import SwiftUI

struct GridPlaceholderView: View {
    let rows = [
        GridItem(.fixed(200)),
        GridItem(.fixed(200))
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 8) {
                ForEach(0..<8, id: \.self) { _ in
                    PlaceholderView(type: .movie)
                        .frame(width: 150)
                }
            }
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    GridPlaceholderView()
}
