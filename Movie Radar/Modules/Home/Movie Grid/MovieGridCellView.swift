//
//  MovieGridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct MovieGridCellView: View {
    @State var movie: Movie

    var body: some View {
        AsyncImage(url: movie.imageUrl) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            PlaceholderView()
                .frame(height: 265)
        }
        .clipped()
        .overlay {
            VStack {
                HStack {
                    Text(movie.title ?? "")
                        .font(.system(size: 14))
                        .foregroundStyle(.white)
                        .shadow(color: Color.black, radius: 2)
                        .padding(6)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
