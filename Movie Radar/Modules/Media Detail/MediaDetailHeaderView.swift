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
            GeometryReader { proxy in
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
                                .clipped()
                                .scaleEffect(viewModel.imageZoom)
                        default:
                            PlaceholderView()
                        }
                    }
                    .frame(
                        width: proxy.size.width,
                        height: proxy.size.height
                    )
                    .onTapGesture {
                        updateHeaderImageVisibility()
                    }
                    .background(
                        GeometryReader { geometry in
                            Color.clear
                                .preference(
                                    key: ScrollOffsetPreferenceKey.self,
                                    value: geometry.frame(in: .named("MediaDetail")).origin
                                )
                        }
                    )
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        var zoomToAdd = value.y / (UIScreen.main.bounds.height / 4)
                        if zoomToAdd < 0 {
                            zoomToAdd = 0
                        }
                        viewModel.imageZoom = 1 + zoomToAdd
                    }
            }
            .frame(height: 600)

            LinearGradient(
                stops: [
                    Gradient.Stop(color: .clear, location: 0.8),
                    Gradient.Stop(color: Color.black, location: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(viewModel.showHeaderGradient ? 0 : 1)
            .onTapGesture {
                updateHeaderImageVisibility()
            }

            VStack {                
                Spacer()
                VStack {
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
                            .shadow(color: .black.opacity(0.5), radius: 1)
                            .background(
                                GeometryReader { geometry in
                                    Color.clear
                                        .preference(
                                            key: ScrollOffsetPreferenceKey.self,
                                            value: geometry.frame(in: .named("MediaDetail")).origin
                                        )
                                }
                            )
                            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                                withAnimation(.spring(duration: 0.25)) {
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
                    }
                }
                .scaleEffect(viewModel.showHeaderInfo ? 0 : 1)
            }
            .padding(.horizontal)
        }
    }
    
    func updateHeaderImageVisibility() {
        withAnimation(.spring(duration: 0.2)) {
            viewModel.showHeaderInfo.toggle()
        }
        withAnimation(.spring(duration: 0.75)) {
            viewModel.showHeaderGradient.toggle()
        }
    }
}
