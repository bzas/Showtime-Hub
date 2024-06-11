//
//  ProviderCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/6/24.
//

import SwiftUI

struct ProviderCarouselCellView: View {
    let imageUrl: URL?
    
    var body: some View {
        AsyncImage(url: imageUrl, content: { image in
            image
                .resizable()
                .scaledToFill()
                .frame(
                    width: 50,
                    height: 50
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }, placeholder: {
            PlaceholderView()
                .frame(
                    width: 50,
                    height: 50
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
}
