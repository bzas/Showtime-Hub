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

        @Published var topRatedList = MovieList()
        @Published var popularList = MovieList()
        @Published var upcomingList = MovieList()
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
                await fetchData()
            }
        }

        func fetchData() async {
            await getPopular()
            await getTopRated()
            await getGenres()
            await getDiscoverMovies()
            await getUpcoming()
        }

        func getTopRated() async {
            if let movieList = await apiService.getTopRatedMovies(page: topRatedList.page) {
                await MainActor.run {
                    topRatedList.append(movieList)
                }
            }
        }

        func getUpcoming() async {
            if let movieList = await apiService.getUpcomingMovies(page: upcomingList.page) {
                await MainActor.run {
                    upcomingList.append(movieList)
                }
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
            guard lastMoviePresented == discoverList.movies.last else { return }

            Task {
                await getDiscoverMovies()
            }
        }

        func getMovieList(type: MovieCarouselType) -> [Movie] {
            switch type {
            case .popular:
                return popularList.movies
            case .topRated:
                return topRatedList.movies
            case .upcoming:
                return upcomingList.movies
            }
        }
    }
}
