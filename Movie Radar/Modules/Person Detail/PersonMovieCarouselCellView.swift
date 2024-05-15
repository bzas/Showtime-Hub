//
//  PersonMovieCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 6/5/24.
//

import SwiftUI

struct PersonMovieCarouselCellView: View {
    var movie: PersonMedia
    let maxWidth = 200.0

    var body: some View {
        VStack(spacing: 2) {
            AsyncImage(url: movie.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: maxWidth, height: maxWidth * 1.33)
            .clipped()

            Text(movie.title ?? "")
                .font(.system(size: 12, weight: .light))
                .lineLimit(2)
                .frame(maxWidth: maxWidth - 8, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .frame(height: 30)
        }
    }
}
