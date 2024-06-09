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
            AsyncImage(
                url: viewModel.media.originalImageUrl,
                transaction: Transaction(
                    animation: .spring(
                        response: 0.5,
                        dampingFraction: 0.65,
                        blendDuration: 0.5)
                )) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .transition(.scale)
                    default:
                        PlaceholderView()
                    }
                }
                .frame(height: 560)
                .clipped()
                .onTapGesture {
                    withAnimation(.linear(duration: 0.25)) {
                        viewModel.showMainImage.toggle()
                    }
                }
            
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .clear, location: 0.6),
                    Gradient.Stop(color: Color.black, location: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(viewModel.showMainImage ? 0 : 1)
            .onTapGesture {
                withAnimation(.linear(duration: 0.25)) {
                    viewModel.showMainImage.toggle()
                }
            }

            VStack {                
                Spacer()
                
                if let trailerUrl = viewModel.media.videoList?.trailerUrl {
                    HStack {
                        Link(destination: trailerUrl) {
                            HStack {
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .scaledToFit()
                                Text("Trailer")
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(.white)
                            .foregroundStyle(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Spacer()
                    }
                }
                
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
            .opacity(viewModel.showMainImage ? 0 : 1)
        }
    }
}
