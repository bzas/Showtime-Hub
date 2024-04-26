//
//  MovieCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 25/4/24.
//

import SwiftUI

extension Color {
    static let brightPurple = Color(red: 187/255, green: 51/255, blue: 255/255)
    static let brightBlue = Color(red: 30/255, green: 144/255, blue: 255/255)
}

extension LinearGradient {
    static let appGradient = LinearGradient(
        gradient: Gradient(colors: [.brightBlue, .brightPurple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

struct MovieCarouselView: View {
    @State var viewModel: ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Popular movies")
                    .foregroundStyle(
                        LinearGradient.appGradient
                    )
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 8) {
                    ForEach(viewModel.movieList.movies, id: \.self) {
                        MovieCarouselCellView(viewModel: .init(movie: $0))
                    }
                }
                .frame(height: 200)
            }
            .scrollIndicators(.hidden)
        }
        .padding()
    }
}

#Preview {
    MovieCarouselView(viewModel: .init(apiService: APIServiceMock()))
}
