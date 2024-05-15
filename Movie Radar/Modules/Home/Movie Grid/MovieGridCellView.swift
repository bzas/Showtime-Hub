//
//  MovieGridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct MovieGridCellView: View {
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
                    Text(movie.title ?? "")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .shadow(radius: 1)
                        .padding(6)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
