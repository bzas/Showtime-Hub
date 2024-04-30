//
//  MovieCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct MovieCarouselCellView: View {
    @State var movie: Movie

    var body: some View {
        VStack {
            AsyncImage(url: movie.posterImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView(type: .movie)
            }
            .frame(width: 100, height: 133)
            .clipped()
            VStack {
                HStack {
                    Text(movie.title ?? "")
                        .font(.system(size: 12))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 80, alignment: .leading)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
