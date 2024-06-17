//
//  GridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 27/4/24.
//

import SwiftUI

struct GridCellView: View {
    @State var mediaName: String
    @State var opacity = 0.0
    @State var cornerRadius: Double = 0.0
    @ObservedObject var imageLoader: ImageLoader

    init(
        media: Media,
        type: MediaType,
        cornerRadius: Double
    ) {
        self.cornerRadius = cornerRadius
        mediaName = media.name
        imageLoader = .init(
            key: media.mediaKey(type: type),
            url: media.posterImageUrl
        )
    }

    var body: some View {
        ZStack {
            buildImage()
                .clipped()
                .aspectRatio(0.6666666667, contentMode: .fill)
            
            LinearGradient(
                stops: [
                    .init(color: .black.opacity(0.5), location: 0),
                    .init(color: .clear, location: 0.3)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .cornerRadius(cornerRadius)
        .overlay {
            VStack {
                HStack {
                    Text(mediaName)
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                        .shadow(radius: 1)
                        .padding(6)
                    Spacer()
                }
                Spacer()
            }
        }
        .opacity(opacity)
    }
    
    @ViewBuilder
    func buildImage() -> some View {
        if let posterImage = imageLoader.image {
            posterImage
                .resizable()
                .scaledToFill()
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
