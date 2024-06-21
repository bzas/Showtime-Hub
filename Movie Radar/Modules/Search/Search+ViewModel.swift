//
//  Search+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 21/6/24.
//

import SwiftUI

struct SearchResult: Hashable {
    var media: Media
    var type: MediaType
}

extension SearchView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Binding var isSearching: Bool
        @Published var searchResults: [SearchResult] = []
        @Published var isLoading = false
        @Published var searchText = "" {
            didSet {
                Task {
                    await searchMedia()
                }
            }
        }
        
        @Published var showDetailMedia = false
        @Published var detailResultToShow: SearchResult? {
            didSet {
                showDetailMedia.toggle()
            }
        }
        
        init(
            apiService: APIService,
            isSearching: Binding<Bool>
        ) {
            self.apiService = apiService
            self._isSearching = isSearching
        }
        
        func searchMedia() async {
            await updateLoading(true)
            guard !searchText.isEmpty else {
                await MainActor.run {
                    searchResults = []
                }
                await updateLoading(false)
                return
            }

            var moviesList = await apiService.searchMovies(
                type: .movie,
                queryString: searchText
            ) ?? MediaList()
            let seriesList = await apiService.searchMovies(
                type: .tv,
                queryString: searchText
            ) ?? MediaList()
            
            let moviesResults: [SearchResult] = moviesList.results.map {
                .init(media: $0, type: .movie)
            }
            
            let seriesResults: [SearchResult] = seriesList.results.map {
                .init(media: $0, type: .tv)
            }
            
            let totalResults = (moviesResults + seriesResults).sorted {
                ($0.media.popularity ?? 0) > ($1.media.popularity ?? 0)
            }
            
            await MainActor.run {
                searchResults = totalResults
            }
            await updateLoading(false)
        }
        
        func updateLoading(_ value: Bool) async {
            await MainActor.run {
                isLoading = value
            }
        }
    }
}
