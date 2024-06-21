//
//  SavedMediaCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/6/24.
//

import SwiftUI

struct SavedMediaCellView: View {
    @State var media: Media
    @State var opacity = 0.0
    @ObservedObject var imageLoader: ImageLoader
    
    init(
        media: Media,
        type: MediaType
    ) {
        self.media = media
        imageLoader = .init(
            key: media.mediaKey(type: type),
            url: media.posterImageUrl
        )
    }
    
    var body: some View {
        HStack(spacing: 16) {
            buildImage()

            VStack(spacing: 6) {
                HStack {
                    Text(media.name)
                        .font(.system(size: 14))
                        .shadow(radius: 2)
                    Spacer()
                }
                
                HStack {
                    Text(media.dateString ?? "")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .shadow(radius: 2)
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(media.genres ?? [], id: \.id) { genre in
                            Text(genre.name)
                                .font(.system(size: 12))
                                .padding(6)
                                .padding(.horizontal, 4)
                                .background(.regularMaterial)
                                .clipShape(Capsule())
                                .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                    content
                                        .opacity(phase.isIdentity ? 1 : 0.5)
                                        .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                }
                        }
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .opacity(opacity)
        .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.5)
                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                .blur(radius: phase.isIdentity ? 0 : 1)
        }
    }
    
    @ViewBuilder
    func buildImage() -> some View {
        if let posterImage = imageLoader.image {
            posterImage
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .clipped()
                .cornerRadius(5)
                .onAppear {
                    makeCellVisible()
                }
        } else if imageLoader.loadingFailed {
            PlaceholderView()
                .onAppear {
                    makeCellVisible()
                }
        } else {
            PlaceholderView()
        }
    }
    
    func makeCellVisible() {
        Task {
            withAnimation(.linear(duration: 0.5)) {
                opacity = 1
            }
        }
    }
}
