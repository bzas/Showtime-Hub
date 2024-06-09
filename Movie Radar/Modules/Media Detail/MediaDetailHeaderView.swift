//
//  MediaDetailHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MediaDetailHeaderView: View {
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
                Spacer()
                
                HStack {
                    Text(viewModel.media.name)
                        .font(.system(size: 30, weight: .light))
                        .lineLimit(6)
                        .shadow(color: Color.black, radius: 2)
                        .background(
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(
                                        key: ScrollOffsetPreferenceKey.self,
                                        value: geometry.frame(in: .named("scroll")).origin
                                    )
                            }
                        )
                        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                            withAnimation(.easeIn(duration: 0.25)) {
                                viewModel.isHeaderHidden = value.y <= 0
                            }
                        }
                    
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
