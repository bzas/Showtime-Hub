//
//  HomeGridView+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation
import SwiftUI

extension HomeGridView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        var type: MediaType
        
        @Published var isLoading = true
        @Published var showToast = false
        @Published var toastInfo: ToastInfo? {
            didSet {
                withAnimation(.spring) {
                    showToast = true
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

        @Published var sortTitle: String = MovieGridSortType.popularityDesc.title
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
            let totalCount = discoverList.results.count
            let correctedCount = totalCount - (discoverList.results.count % 3)
            return Array(discoverList.results[0..<correctedCount])
        }

        init(
            apiService: APIService,
            type: MediaType
        ) {
            self.apiService = apiService
            self.type = type
            Task {
                await fetchData()
            }
        }

        func fetchData() async {
            await getGenres()
            await getDiscoverContent()
        }

        func refreshGrid() {
            Task {
                await updateLoading(true)
            }
            discoverList = MediaList()
            Task {
                await getDiscoverContent()
            }
        }

        func getGenres() async {
            guard let genreList = await apiService.getGenres(type: type) else { return }
            
            await MainActor.run {
                self.genreList = genreList
            }
        }
        
        func continueFetchIfNeeded() async {
            if !isSearching {
                await getDiscoverContent()
            }
        }

        func getDiscoverContent() async {
            await updateLoading(true)
            guard let mediaList = await apiService.discoverMedia(
                type: type,
                genreId: selectedGenre?.id,
                sortType: type.isMovie ? movieSortType.requestKey : seriesSortType.requestKey,
                page: discoverList.page
            ) else {
                await updateLoading(false)
                return
            }
            
            let itemsToAdd = discoverList.filteredList(mediaList)
            let cachedItems = mediaList.results.map { mediaItem in
                CachedItem(
                    key: mediaItem.mediaKey(type: type),
                    media: mediaItem
                )
            }
            
            await ImageCache.shared.load(
                items: cachedItems
            )
            
            await MainActor.run {
                discoverList.append(itemsToAdd)
            }
            await updateLoading(false)
        }

        func selectGenre(genre: Genre) {
            if selectedGenre == genre {
                selectedGenre = nil
            } else {
                selectedGenre = genre
            }

            refreshGrid()
        }

        func isSelected(genre: Genre) -> Bool {
            genre == selectedGenre
        }
        
        func updateLoading(_ value: Bool) async {
            await MainActor.run {
                isLoading = value
            }
        }
    }
}
