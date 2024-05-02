//
//  SimilarMoviesCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct RecommendationsCarouselCellView: View {
    var movie: Movie
    let maxWidth = 150.0

    var body: some View {
        VStack {
            AsyncImage(url: movie.wideImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView(type: .movie)
            }
            .frame(width: maxWidth, height: 100)
            .clipped()

            Text(movie.title ?? "")
                .font(.system(size: 12, weight: .light))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: maxWidth - 8, alignment: .leading)
            Spacer()
        }
    }
}