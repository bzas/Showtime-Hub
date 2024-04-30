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
        @Published var movieActors: [Cast] = []

        init(apiService: APIService, movie: Movie) {
            self.apiService = apiService
            self.movie = movie
            Task {
                await fetchDetailMovie()
                await fetchMovieActors()
            }
        }

        func fetchDetailMovie() async {
            if let movieDetail = await apiService.getMovieDetail(id: movie.id) {
                await MainActor.run {
                    movie = movieDetail
                }
            }
        }

        func fetchMovieActors() async {
            if let movieActors = await apiService.getMovieActors(id: movie.id) {
                await MainActor.run {
                    self.movieActors = movieActors
                }
            }
        }
    }
}
