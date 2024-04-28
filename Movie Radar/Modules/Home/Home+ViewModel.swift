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
            Task {
                try await fetchData()
            }
        }

        func fetchData() async throws {
            try await getPopular()
            try await getGenres()
            try await discoverMovies()
        }

        func getPopular() async throws {
            if let movieList = try await apiService.getPopularMovies(page: popularList.page) {
                await MainActor.run {
                    popularList.append(movieList)
                }
            }
        }

        func getGenres() async throws {
            if let genreList = try await apiService.getGenres() {
                await MainActor.run {
                    self.genreList = genreList
                }
            }
        }

        func discoverMovies() async throws {
            print("PAGE: ")
            print(discoverList.page)
            if let movieList = try await apiService.discoverMovies(
                genreId: selectedGenre?.id,
                page: discoverList.page
            ) {
                await MainActor.run {
                    discoverList.append(movieList)
                }
            }
        }

        func selectGenre(genre: Genre) {
            if selectedGenre == genre {
                selectedGenre = nil
            } else {
                selectedGenre = genre
            }

            discoverList = MovieList()
            Task {
                try await discoverMovies()
            }
        }

        func isSelected(genre: Genre) -> Bool {
            genre == selectedGenre
        }

        func continueFetchIfNeeded(lastMoviePresented: Movie) {
            guard lastMoviePresented == discoverList.movies.last else { return }

            Task {
                try await discoverMovies()
            }
        }
    }
}
