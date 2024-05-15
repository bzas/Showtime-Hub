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

        @Published var upcomingList = MediaList()
        @Published var searchList = MediaList()
        @Published var searchText = "" {
            didSet {
                Task {
                    await searchMovies()
                }
            }
        }
        @Published var genreList = GenreList()
        @Published var discoverList = MediaList()
        @Published var showDetailMovie = false
        @Published var isSearching = false
        @Published var detailMovieToShow: Media? {
            didSet {
                showDetailMovie.toggle()
            }
        }

        @Published var selectedGenre: Genre?
        @Published var sortType: GridSortType = .popularityDesc {
            didSet {
                refreshGrid()
            }
        }

        var gridMovies: [Media] {
            if searchText.isEmpty {
                return discoverList.results
            }

            return searchList.results
        }

        init(apiService: APIService) {
            self.apiService = apiService
            Task {
                await fetchData()
            }
        }

        func fetchData() async {
            await getUpcoming()
            await getGenres()
            await getDiscoverMovies()
        }

        func refreshGrid() {
            discoverList = MediaList()
            Task {
                await getDiscoverMovies()
            }
        }

        func getUpcoming() async {
            if let movieList = await apiService.getUpcomingMovies(page: upcomingList.page) {
                await MainActor.run {
                    upcomingList.append(movieList)
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
                sortType: sortType.requestKey,
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
                    searchList = MediaList()
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

            discoverList = MediaList()
            Task {
                await getDiscoverMovies()
            }
        }

        func isSelected(genre: Genre) -> Bool {
            genre == selectedGenre
        }

        func continueFetchIfNeeded(lastMoviePresented: Media) {
            guard searchText.isEmpty,
                  lastMoviePresented == discoverList.results.last else { return }

            Task {
                await getDiscoverMovies()
            }
        }

        func updateVisibility(isEditingSearch: Bool) {
            isSearching = isEditingSearch || !searchText.isEmpty
        }
    }
}
