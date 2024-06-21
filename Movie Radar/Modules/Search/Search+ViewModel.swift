//
//  Search+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 21/6/24.
//

import SwiftUI

extension SearchView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Binding var isSearching: Bool
        @Published var searchResults: [SearchResult] = []
        @Published var isLoading = false
        @Published var searchText = ""
        @Published var showDetailMedia = false
        @Published var detailResultToShow: SearchResult? {
            didSet {
                showDetailMedia.toggle()
            }
        }
        
        @Published var showToast = false
        @Published var toastInfo: ToastInfo? {
            didSet {
                withAnimation(.spring) {
                    showToast = true
                }
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

            let allSearchResults = await apiService.searchAllMedia(queryString: searchText)
            await MainActor.run {
                searchResults = allSearchResults
                isLoading = false
            }
        }
        
        func updateLoading(_ value: Bool) async {
            await MainActor.run {
                isLoading = value
            }
        }
        
        func resetSearch() {
            searchText = ""
            Task {
                await searchMedia()
            }
        }
    }
}
