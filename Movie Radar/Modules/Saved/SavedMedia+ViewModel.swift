//
//  SavedMedia+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import SwiftData

extension SavedMediaView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        var localStorage: LocalStorage
        @Published var selectedMediaType = MediaType.all
        @Published var selectedTab = 0
        @Published var showFilters = false
        @Published var showUserLists = false
        @Published var searchText = ""
        @Published var filtersApplied = false
        @Published var startDate = LocalStorage.defaultDate
        @Published var endDate = LocalStorage.defaultEndDate
        @Published var showDetailMedia = false
        @Published var detailMediaToShow: SavedMedia? {
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
            modelContext: ModelContext
        ) {
            self.apiService = apiService
            self.localStorage = LocalStorage(modelContext: modelContext)
        }
        
        func filtersPredicate(userList: UserList) -> Predicate<SavedMedia>? {
            LocalStorage.buildFilterPredicate(
                mediaType: selectedMediaType,
                userList: userList,
                searchText: searchText,
                startDate: startDate,
                endDate: endDate
            )
        }
    }
}
