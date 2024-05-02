//
//  MovieCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct ImageCarouselCellView: View {
    var imageInfo: MovieImage

    var body: some View {
        AsyncImage(url: imageInfo.originalImageUrl) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView(type: .movie)
        }
        .frame(width: 133, height: 200)
        .clipped()
    }
}
