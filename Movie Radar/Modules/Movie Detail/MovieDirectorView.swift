//
//  MovieDirectorView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 14/5/24.
//

import SwiftUI

struct MovieDirectorView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel

    var body: some View {
        HStack(spacing: 18) {
            AsyncImage(url: viewModel.director?.imageUrl) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView()
            }
            .frame(width: 75, height: 75)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack {
                HStack {
                    Text(viewModel.director?.name ?? "")
                        .font(.system(size: 18))
                    Spacer()
                }

                HStack {
                    Text("Director")
                        .font(.system(size: 14, weight: .light))
                    Spacer()
                }
            }
            Spacer()
        }
        .padding(.bottom)
        .onTapGesture {
            viewModel.detailPersonToShow = viewModel.director
        }
    }
}

#Preview {
    MovieDirectorView()
}
