//
//  MovieActorCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/4/24.
//

import SwiftUI

struct MovieActorCarouselCellView: View {
    var movieActor: Cast

    var body: some View {
        VStack {
            AsyncImage(url: movieActor.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView(type: .person)
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())

            VStack {
                Text(movieActor.name ?? "")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12, weight: .light))
                Text(movieActor.character ?? "")
                    .font(.system(size: 10, weight: .thin))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                Spacer()
            }
            .frame(height: 80)
            .frame(maxWidth: 90)
        }
    }
}
