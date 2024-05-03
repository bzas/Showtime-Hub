//
//  ImageDetailCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 3/5/24.
//

import SwiftUI

struct ImageDetailView: View {
    @State var viewModel: ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows) {
                        ForEach(Array(viewModel.images.enumerated()), id: \.1.self) { (index, poster) in
                            AsyncImage(url: poster.originalImageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                Color.clear
                            }
                            .id(index)
                            .frame(width: proxy.size.width / 1.25)
                            .clipped()
                            .onTapGesture {
                                print("Tapped")
                            }
                            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.6)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                    .blur(radius: phase.isIdentity ? 0 : 2)
                            }
                        }
                    }
                    .padding(.leading, (proxy.size.width - (proxy.size.width / 1.25)) / 2)
                    .padding(.trailing, (proxy.size.width - (proxy.size.width / 1.25)) / 2)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                Spacer()
            }
            .background(.clear)
            .onTapGesture {
                viewModel.showDetailImage.wrappedValue = false
            }
        }
    }
}
