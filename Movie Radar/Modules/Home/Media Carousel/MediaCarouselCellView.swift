//
//  MediaCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import SwiftUI

struct MediaCarouselCellView: View {
    @State var media: Media
    
    var body: some View {
        ZStack {
            AsyncImage(url: media.originalImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.width / 0.666666
            )
            .clipped()
            
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .clear, location: 0.6),
                    Gradient.Stop(color: Color.black, location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .padding(.bottom, 66)
        .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.6)
                .blur(radius: phase.isIdentity ? 0 : 2)
        }
        .overlay {
            VStack(spacing: 6) {
                Spacer()
                
                Text(media.name)
                    .font(.system(size: 20))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .shadow(radius: 2)
                
                Text(media.dateString ?? "")
                    .font(.system(size: 12, weight: .light))
                
                Text(media.overview ?? "")
                    .font(.system(size: 14))
                    .lineLimit(6)
                    .multilineTextAlignment(.center)
                    .padding(.top, 10)

            }
            .padding(.horizontal)
        }
    }
}
