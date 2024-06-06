//
//  MediaDetailHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MediaDetailHeaderView: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel

    var body: some View {
        ZStack {
            AsyncImage(url: viewModel.media.originalImageUrl) { image in
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
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.black)
                            .padding(10)
                            .background(.white.opacity(0.5))
                            .clipShape(Circle())
                            .shadow(color: .black, radius: 4)
                    }
                    
                    Spacer()
                    
                    SaveMediaStackView(
                        media: viewModel.media,
                        mediaType: viewModel.type
                    )
                }
                .padding(.top, safeAreaInsets.top + 10)

                Spacer()
                
                HStack {
                    Text(viewModel.media.name)
                        .font(.system(size: 30, weight: .light))
                        .lineLimit(6)
                        .shadow(color: Color.black, radius: 2)
                    Spacer()
                }
                .padding(.trailing)

                if let runtime = viewModel.media.runtime {
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
