//
//  SocialNetworkCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct LinksCarouselCellView: View {
    var link: MovieLink

    var body: some View {
        Link(destination: link.url) {
            Image(link.type.imageName)
                .resizable()
                .scaledToFill()
                .frame(
                    width: 50,
                    height: 50
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}
