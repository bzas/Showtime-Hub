//
//  CarouselPlaceholderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 29/4/24.
//

import SwiftUI

struct CarouselPlaceholderView: View {
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 8) {
                ForEach(0..<8, id: \.self) { _ in
                    VStack {
                        PlaceholderView(type: .movie)
                            .frame(width: 100, height: 133)
                        HStack {
                            UIColor.systemGray5.color
                            Color.clear
                        }
                        .frame(height: 10)
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    CarouselPlaceholderView()
}
