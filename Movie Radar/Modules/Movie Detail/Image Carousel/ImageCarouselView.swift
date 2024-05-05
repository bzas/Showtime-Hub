//
//  MovieCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct ImageCarouselView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Images")
                    .foregroundStyle(LinearGradient.appGradient)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.imageList.posters.isEmpty {
                NoDataAvailableView(title: "No images available")
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 16) {
                        ForEach(Array(viewModel.imageList.posters.enumerated()), id: \.1.self) { (index, imageInfo) in
                            ImageCarouselCellView(imageInfo: imageInfo)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.imageIndexToShow = index
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    ImageCarouselView()
}
