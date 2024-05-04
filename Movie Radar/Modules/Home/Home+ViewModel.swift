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
        @Published var searchList = MovieList()
        @Published var searchText = "" {
            didSet {
                Task {
                    await searchMovies()
                }
            }
        }
        @Published var genreList = GenreList()
        @Published var discoverList = MovieList()
        @Published var showDetailMovie = false
        @Published var detailMovieToShow: Movie? {
            didSet {
                showDetailMovie.toggle()
            }
        }

        @Published var selectedGenre: Genre?

        var gridMovies: [Movie] {
            if searchText.isEmpty {
                return discoverList.movies
            }

            return searchList.movies
        }

        init(apiService: APIService) {
            self.apiService = apiService
            Task {
                await fetchData()
            }
        }

        func fetchData() async {
            await getPopular()
            await getGenres()
            await getDiscoverMovies()
        }

        func refreshData() {
            popularList = MovieList()
            discoverList = MovieList()
            genreList = GenreList()
            Task {
                await fetchData()
            }
        }

        func getPopular() async {
            if let movieList = await apiService.getPopularMovies(page: popularList.page) {
                await MainActor.run {
                    popularList.append(movieList)
                }
            }
        }

        func getGenres() async {
            if let genreList = await apiService.getGenres() {
                await MainActor.run {
                    self.genreList = genreList
                }
            }
        }

        func getDiscoverMovies() async {
            if let movieList = await apiService.discoverMovies(
                genreId: selectedGenre?.id,
                page: discoverList.page
            ) {
                await MainActor.run {
                    discoverList.append(movieList)
                }
            }
        }

        func searchMovies() async {
            guard !searchText.isEmpty else {
                await MainActor.run {
                    searchList = MovieList()
                }
                return
            }

            if let movieList = await apiService.searchMovies(
                queryString: searchText
            ) {
                await MainActor.run {
                    searchList = movieList
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
                await getDiscoverMovies()
            }
        }

        func isSelected(genre: Genre) -> Bool {
            genre == selectedGenre
        }

        func continueFetchIfNeeded(lastMoviePresented: Movie) {
            guard searchText.isEmpty,
                  lastMoviePresented == discoverList.movies.last else { return }

            Task {
                await getDiscoverMovies()
            }
        }
    }
}
