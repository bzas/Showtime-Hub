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
            AsyncImage(url: movie.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: 100, height: 133)
            .clipped()
            VStack {
                Text(movie.title ?? "")
                    .font(.system(size: 12))
                    .lineLimit(3)
                    .frame(maxWidth: 100)
                Spacer()
            }
        }
    }
}
