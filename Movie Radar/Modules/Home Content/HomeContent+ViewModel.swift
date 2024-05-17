//
//  HomeContentView+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension HomeContentView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        var type: MediaType

        @Published var upcomingList = MediaList()
        @Published var searchList = MediaList()
        @Published var searchText = "" {
            didSet {
                Task {
                    await searchMedia()
                }
            }
        }
        @Published var genreList = GenreList()
        @Published var discoverList = MediaList()
        @Published var showDetailMedia = false
        @Published var isSearching = false
        @Published var detailMediaToShow: Media? {
            didSet {
                showDetailMedia.toggle()
            }
        }

        @Published var sortTitle: String = "Popularity"
        @Published var selectedGenre: Genre?
        @Published var movieSortType: MovieGridSortType = .popularityDesc {
            didSet {
                sortTitle = movieSortType.title
                refreshGrid()
            }
        }
        @Published var seriesSortType: SeriesGridSortType = .popularityDesc {
            didSet {
                sortTitle = seriesSortType.title
                refreshGrid()
            }
        }
        
        var gridItems: [Media] {
            if searchText.isEmpty {
                return discoverList.results
            }

            return searchList.results
        }

        init(apiService: APIService, type: MediaType) {
            self.apiService = apiService
            self.type = type
            Task {
                await fetchData()
            }
        }

        func fetchData() async {
            await getUpcoming()
            await getGenres()
            await getDiscoverContent()
        }

        func refreshGrid() {
            discoverList = MediaList()
            Task {
                await getDiscoverContent()
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
            if let genreList = await apiService.getGenres(type: type) {
                await MainActor.run {
                    self.genreList = genreList
                }
            }
        }

        func getDiscoverContent() async {
            if let mediaList = await apiService.discoverMedia(
                type: type,
                genreId: selectedGenre?.id,
                sortType: type.isMovie ? movieSortType.requestKey : seriesSortType.requestKey,
                page: discoverList.page
            ) {
                await MainActor.run {
                    discoverList.append(mediaList)
                }
            }
        }

        func searchMedia() async {
            guard !searchText.isEmpty else {
                await MainActor.run {
                    searchList = MediaList()
                }
                return
            }

            if let movieList = await apiService.searchMovies(
                type: type,
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
                await getDiscoverContent()
            }
        }

        func isSelected(genre: Genre) -> Bool {
            genre == selectedGenre
        }

        func continueFetchIfNeeded(lastMoviePresented: Media) {
            guard searchText.isEmpty,
                  lastMoviePresented == discoverList.results.last else { return }

            Task {
                await getDiscoverContent()
            }
        }

        func updateVisibility(isEditingSearch: Bool) {
            isSearching = isEditingSearch || !searchText.isEmpty
        }
    }
}
