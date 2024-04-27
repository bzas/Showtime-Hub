//
//  MovieDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct MovieDetailView: View {
    @State var viewModel: ViewModel

    var body: some View {
        VStack {
            AsyncImage(url: viewModel.movie.wideImageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                PlaceholderView()
                    .frame(maxHeight: 220)
            }
            .clipped()
            HStack {
                Text(viewModel.movie.title ?? "")
                    .font(.system(size: 25, weight: .light))
                    .lineLimit(3)
                Spacer()
            }
            .padding(.horizontal)
            Spacer()
        }
        .presentationDetents([.medium, .large])
    }
}
