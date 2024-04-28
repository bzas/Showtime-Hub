//
//  MovieDetailViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension MovieDetailView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Published var movie: Movie

        init(apiService: APIService, movie: Movie) {
            self.apiService = apiService
            self.movie = movie
            Task {
                await fetchDetailMovie()
            }
        }

        func fetchDetailMovie() async {
            if let movieDetail = await apiService.getMovieDetail(id: movie.id) {
                await MainActor.run {
                    movie = movieDetail
                }
            }
        }
    }
}
