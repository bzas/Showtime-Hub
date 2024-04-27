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

        @Published var popularList = MovieList()
        @Published var discoverList = MovieList()
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
            discoverMovies()
        }

        func getPopular() {
            Task {
                if let movieList = try await apiService.getPopularMovies(page: popularList.page) {
                    await MainActor.run {
                        popularList.append(movieList)
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

        func discoverMovies() {
            Task {
                if let movieList = try await apiService.discoverMovies(genreId: selectedGenre?.id, page: 1) {
                    await MainActor.run {
                        self.discoverList = movieList
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

            discoverMovies()
        }

        func isSelected(genre: Genre) -> Bool {
            genre == selectedGenre
        }
    }
}
