//
//  SavedMedia+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation
import SwiftData

extension SavedMediaView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        var localStorage: LocalStorage
        @Published var selectedMediaType = MediaType.all
        @Published var selectedTab = 0
        @Published var showFilters = false
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
                showToast.toggle()
            }
        }
        
        var currentSavedType: SavedType {
            SavedType.allCases.enumerated().first { (index, savedType) in
                index == selectedTab
            }?.element ?? .favorites
        }

        init(
            apiService: APIService,
            modelContext: ModelContext
        ) {
            self.apiService = apiService
            self.localStorage = LocalStorage(modelContext: modelContext)
        }
        
        func filtersPredicate(savedType: SavedType) -> Predicate<SavedMedia>? {
            LocalStorage.buildFilterPredicate(
                mediaType: selectedMediaType,
                savedType: savedType,
                searchText: searchText,
                startDate: startDate,
                endDate: endDate
            )
        }
    }
}
