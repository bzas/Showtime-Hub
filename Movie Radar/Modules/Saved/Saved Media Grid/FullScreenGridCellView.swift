//
//  FullScreenGridCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct FullScreenGridCellView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    @State var media: SavedMedia
    var proxy: GeometryProxy

    var body: some View {
        ZStack {
            AsyncImage(url: media.detail.originalImageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(height: proxy.size.height)
            .clipped()
            
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .clear, location: 0.6),
                    Gradient.Stop(color: Color.black, location: 1)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack {
                Spacer()
                HStack {
                    Text(media.detail.publicName)
                        .font(.system(size: 25))
                        .shadow(radius: 2)
                    Spacer()
                }
                .padding(.trailing, 40)
                
                HStack {
                    Button {
                        viewModel.detailMediaToShow = media
                    } label: {
                        HStack {
                            Text("See details")
                            Image(systemName: "chevron.right")
                        }
                        .opacity(0.6)
                    }

                    Spacer()
                }
            }
            .padding(20)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    SaveMediaStackView(
                        media: media.detail,
                        mediaType: media.type, 
                        axis: .vertical
                    )
                }
            }
            .padding(20)
        }
        .scrollTransition(.animated.threshold(.visible(0.5))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.6)
                .blur(radius: phase.isIdentity ? 0 : 2)
        }
    }
}
