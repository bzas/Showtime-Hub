//
//  MediaDetailHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MediaDetailHeaderView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel

    var body: some View {
        ZStack {
            AsyncImage(url: viewModel.movie.originalImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(height: 560)
            .clipped()

            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color.black, location: 0.025),
                    Gradient.Stop(color: Color.black.opacity(0.5), location: 0.1),
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
                            .foregroundStyle(.white.opacity(0.3))
                            .padding(4)
                            .padding(.top)
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

                if let runtime = viewModel.movie.runtime {
                    HStack {
                        Text("\(runtime) min")
                            .font(.system(size: 14, weight: .light))
                        Spacer()
                    }
                    .padding(.bottom)
                }

                GenreCarouselView()
                    .environmentObject(viewModel)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    MediaDetailHeaderView()
}
