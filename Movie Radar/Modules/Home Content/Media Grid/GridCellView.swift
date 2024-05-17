//
//  GridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GridCellView: View {
    @State var movie: Media

    var body: some View {
        AsyncImage(url: movie.posterImageUrl) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView()
        }
        .frame(height: 275)
        .clipped()
        .overlay {
            VStack {
                HStack {
                    Text(movie.publicName)
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .shadow(radius: 1)
                        .padding(6)
                    Spacer()
                }
                Spacer()
            }
        }
        .scrollTransition(.animated.threshold(.visible(0.3))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.6)
                .blur(radius: phase.isIdentity ? 0 : 2)
        }
    }
}
