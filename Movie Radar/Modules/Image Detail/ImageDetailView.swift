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
            VStack(spacing: 8) {
                Spacer()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows) {
                        ForEach(Array(viewModel.images.enumerated()), id: \.1.self) { (index, imageData) in
                            VStack(spacing: 20) {
                                Spacer()
                                AsyncImage(
                                    url: imageData.imageUrl,
                                    transaction: Transaction(animation: .smooth)) { phase in
                                        switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .transition(.scale)
                                        default:
                                            Color.clear
                                        }
                                    }
                                    .id(index)
                                    .frame(width: proxy.size.width / (viewModel.isBigImage ? 1.25 : 2.5))
                                    .clipped()
                                
                                VStack {
                                    if let name = imageData.name {
                                        Text(name)
                                            .font(.system(size: 22, weight: .semibold))
                                    }
                                    
                                    if let subtitle = imageData.subtitle {
                                        Text(subtitle)
                                            .font(.system(size: 14))
                                    }
                                    
                                    if let description = imageData.descriptionText {
                                        ScrollView {
                                            Text(description)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 12, weight: .light))
                                                .frame(width: proxy.size.width / 1.25)
                                        }
                                        .frame(maxHeight: 250)
                                    }
                                }
                            }
                            .padding(.vertical, 25)
                            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.6)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                    .blur(radius: phase.isIdentity ? 0 : 2)
                            }
                            .contextMenu {
                                if viewModel.isBigImage {
                                    Button {
                                        viewModel.downloadImage(url: imageData.imageUrl)
                                    } label: {
                                        HStack {
                                            Image(systemName: "arrow.down.square")
                                            Text("Save on photos")
                                        }
                                    }
                                    
                                    Button {
                                        viewModel.urlToShare = imageData.imageUrl
                                    } label: {
                                        HStack {
                                            Image(systemName: "square.and.arrow.up")
                                            Text("Share")
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, (proxy.size.width - (proxy.size.width / 1.25)) / 2)
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
                withAnimation(.spring(duration: 0.25)) {
                    viewModel.showDetail = false
                }
            }
        }
        .transition(
            .asymmetric(
                insertion: .scale(scale: 0.01),
                removal: .scale(scale: 0.01)
            )
        )
    }
}
