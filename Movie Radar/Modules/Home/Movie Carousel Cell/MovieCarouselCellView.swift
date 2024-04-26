//
//  MovieCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct MovieCarouselCellView: View {
    @State var viewModel: ViewModel

    var body: some View {
        VStack {
            ZStack {
                AsyncImage(
                    url: viewModel.imageUrl,
                    transaction: Transaction()) { phase in
                        switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            default:
                                Rectangle()
                                    .fill(.gray)
                        }
                    }
                    .frame(width: 100, height: 133)
                    .clipped()
                VStack {
                    HStack {
                        Spacer()
                        FavoriteButton {}
                    }
                    Spacer()
                }
            }
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 12))
                    .lineLimit(3)
                    .frame(maxWidth: 100)
                Spacer()
            }
        }
    }
}

#Preview {
    MovieCarouselCellView(
        viewModel: .init(
            movie: Movie(
                backdropPath: "",
                id: 123,
                title: "Movie title",
                voteAverage: 3.14,
                popularity: 8.8,
                overview: "Overview",
                releaseDate: "14/08/2025"
            )
        )
    )
}
