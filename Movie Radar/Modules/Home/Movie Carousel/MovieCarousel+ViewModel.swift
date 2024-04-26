//
//  MovieCarouselViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 25/4/24.
//

import Foundation

extension MovieCarouselView {
    @Observable
    class ViewModel {
        var apiService: APIService
        var movieList = MovieList()

        init(apiService: APIService) {
            self.apiService = apiService
            getPopular()
        }

        func getPopular() {
            Task {
                if let newMovieList = try await apiService.getPopularMovies(page: movieList.page) {
                    movieList.append(newMovieList)
                }
            }
        }
    }
}
