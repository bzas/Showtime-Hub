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

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 16) {
                    ForEach(viewModel.imageList.posters, id: \.self) { imageInfo in
                        ImageCarouselCellView(imageInfo: imageInfo)
                    }
                }
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    ImageCarouselView()
}
