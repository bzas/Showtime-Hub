//
//  MovieDetailHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MovieDetailHeaderView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel

    var body: some View {
        ZStack {
            AsyncImage(url: viewModel.movie.originalImageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                PlaceholderView(type: .movie)
                    .frame(height: 560)
            }
            .clipped()

            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color.black, location: 0.05),
                    Gradient.Stop(color: .clear, location: 0.6),
                    Gradient.Stop(color: Color.black, location: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white.opacity(0.4))
                    }
                    Spacer()
                }

                Spacer()
                HStack {
                    Text(viewModel.movie.title ?? "")
                        .font(.system(size: 30, weight: .light))
                        .lineLimit(6)
                        .shadow(color: Color.black, radius: 2)
                    Spacer()
                }
                .padding(.trailing)
                GenreCarouselView()
                    .environmentObject(viewModel)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MovieDetailHeaderView()
}
