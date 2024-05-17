//
//  ImageDetailCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 3/5/24.
//

import SwiftUI

struct ImageDetailView: View {
    @StateObject var viewModel: ViewModel
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
                            AsyncImage(
                                url: poster.originalImageUrl,
                                transaction: Transaction(animation: .smooth)) { phase in
                                    switch phase {
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    default:
                                        Color.clear
                                    }
                                }
                            .id(index)
                            .frame(width: proxy.size.width / 1.25)
                            .clipped()
                            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.6)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                    .blur(radius: phase.isIdentity ? 0 : 2)
                            }
                            .contextMenu {
                                Button {
                                    viewModel.downloadImage(url: poster.originalImageUrl)
                                } label: {
                                    HStack {
                                        Image(systemName: "arrow.down.square")
                                        Text("Save on photos")
                                    }
                                }

                                Button {
                                    viewModel.urlToShare = poster.originalImageUrl
                                } label: {
                                    HStack {
                                        Image(systemName: "square.and.arrow.up")
                                        Text("Share")
                                    }
                                }

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
            .sheet(isPresented: $viewModel.isSharePresented) {
                if let url = viewModel.urlToShare {
                    ActivityView(activityItems: [url])
                }
            }
            .onTapGesture {
                viewModel.showDetailImage.wrappedValue = false
            }
        }
    }
}
