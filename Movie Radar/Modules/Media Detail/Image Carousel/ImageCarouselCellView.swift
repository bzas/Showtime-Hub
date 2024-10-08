//
//  MediaCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct ImageCarouselCellView: View {
    var imageInfo: MediaImage

    var body: some View {
        AsyncImage(url: imageInfo.originalImageUrl) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView()
        }
        .frame(width: 200, height: 300)
        .clipped()
    }
}
