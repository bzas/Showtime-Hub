//
//  HomeViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension HomeView {
    class ViewModel: ObservableObject {
        var apiService: APIService

        @Published var movieList = MovieList()
        @Published var genreList = GenreList()
        @Published var showDetailMovie = false
        @Published var detailMovieToShow: Movie? {
            didSet {
                showDetailMovie.toggle()
            }
        }

        @Published var selectedGenre: Genre?

        init(apiService: APIService) {
            self.apiService = apiService
            getPopular()
            getGenres()
        }

        func getPopular() {
            Task {
                if let newMovieList = try await apiService.getPopularMovies(page: movieList.page) {
                    await MainActor.run {
                        movieList.append(newMovieList)
                    }
                }
            }
        }

        func getGenres() {
            Task {
                if let genreList = try await apiService.getGenres() {
                    await MainActor.run {
                        self.genreList = genreList
                    }
                }
            }
        }

        func selectGenre(genre: Genre) {
            if selectedGenre == genre {
                selectedGenre = nil
            } else {
                selectedGenre = genre
            }
        }

        func isSelected(genre: Genre) -> Bool {
            genre == selectedGenre
        }
    }
}
