//
//  ListGridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct ListGridCellView: View {
    @State var media: Media

    var body: some View {
        AsyncImage(url: media.posterImageUrl) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView()
        }
        .frame(height: 185)
        .clipped()
    }
}
