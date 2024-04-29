//
//  GridPlaceholderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 29/4/24.
//

import SwiftUI

struct GridPlaceholderView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(0..<8, id: \.self) { _ in
                PlaceholderView()
                    .frame(height: 265)
            }
        }
        .padding(.horizontal, 6)
    }
}

#Preview {
    GridPlaceholderView()
}
