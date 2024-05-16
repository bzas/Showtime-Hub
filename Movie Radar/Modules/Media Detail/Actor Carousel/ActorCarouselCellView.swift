//
//  ActorCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/4/24.
//

import SwiftUI

struct ActorCarouselCellView: View {
    var mediaActor: Cast

    var body: some View {
        VStack {
            AsyncImage(url: mediaActor.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: 100, height: 100)
            .clipShape(Circle())

            VStack {
                Text(mediaActor.name ?? "")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 12, weight: .light))
                Text(mediaActor.character ?? "")
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
