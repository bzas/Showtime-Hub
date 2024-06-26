//
//  MediaCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MediaCarouselCellView: View {
    var media: Media
    let maxWidth = 200.0

    var body: some View {
        VStack(spacing: 2) {
            AsyncImage(url: media.wideImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: maxWidth, height: maxWidth * 0.66)
            .clipped()

            Text(media.name)
                .font(.system(size: 12, weight: .light))
                .lineLimit(2)
                .frame(maxWidth: maxWidth - 8, alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .frame(height: 30)
        }
    }
}
