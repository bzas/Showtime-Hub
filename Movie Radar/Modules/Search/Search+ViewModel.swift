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
        @Published var searchMediaResults: [SearchResult] = []
        @Published var searchPeopleResults = PersonList(results: [])
        @Published var isLoading = false
        @Published var searchText = ""
        @Published var showDetailMedia = false
        @Published var detailResultToShow: SearchResult? {
            didSet {
                showDetailMedia.toggle()
            }
        }
        
        @Published var showDetailPerson = false
        @Published var detailPersonIdToShow: Int? {
            didSet {
                showDetailPerson.toggle()
            }
        }
        
        @Published var showToast = false
        @Published var toastInfo: ToastInfo? {
            didSet {
                withAnimation(.spring(duration: 0.3)) {
                    showToast = true
                }
            }
        }
        
        @Published var isShowingMediaResults = true
        
        init(
            apiService: APIService,
            isSearching: Binding<Bool>
        ) {
            self.apiService = apiService
            self._isSearching = isSearching
        }
        
        func search() {
            Task {
                await searchMedia()
                await searchPeople()
            }
        }
        
        func searchMedia() async {
            await updateLoading(true)
            guard !searchText.isEmpty else {
                await MainActor.run {
                    searchMediaResults = []
                }
                await updateLoading(false)
                return
            }

            let allSearchResults = await apiService.searchAllMedia(queryString: searchText)
            await MainActor.run {
                searchMediaResults = allSearchResults
            }
            
            try? await Task.sleep(nanoseconds: 250_000_000)
            await updateLoading(false)
        }
        
        func searchPeople() async {
            await updateLoading(true)
            guard !searchText.isEmpty else {
                await MainActor.run {
                    searchMediaResults = []
                    searchPeopleResults = PersonList(results: [])
                }
                await updateLoading(false)
                return
            }

            if let searchResults = await apiService.searchPerson(queryString: searchText) {
                await MainActor.run {
                    searchPeopleResults = searchResults
                }
            }
            
            try? await Task.sleep(nanoseconds: 250_000_000)
            await updateLoading(false)
        }
        
        func updateLoading(_ value: Bool) async {
            await MainActor.run {
                isLoading = value
            }
        }
        
        func resetSearch() {
            searchText = ""
            Task {
                await search()
            }
        }
    }
}
