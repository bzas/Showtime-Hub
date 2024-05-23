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
        @Published var movieItems: [Media] = []
        @Published var seriesItems: [Media] = []
        @Published var showFilters = false
        @Published var searchText = ""
        @Published var filtersApplied = false
        @Published var startDate: Date?
        @Published var endDate: Date?

        @Published var showDetailMedia = false
        @Published var detailMediaToShow: SavedMedia? {
            didSet {
                showDetailMedia.toggle()
            }
        }

        init(apiService: APIService, modelContext: ModelContext) {
            self.apiService = apiService
            self.localStorage = LocalStorage(modelContext: modelContext)
        }
        
        func items(items: [SavedMedia], savedType: SavedType) -> [SavedMedia] {
            items
                .filter {
                    selectedMediaType == .all ? true : $0.type == selectedMediaType
                }
                .filter {
                    $0.savedType == savedType
                }
                .filter {
                    searchText.isEmpty ? true : $0.detail.name.contains(searchText)
                }
                .filter {
                    if let date = $0.detail.date,
                       let startDate,
                       let endDate {
                        return date > startDate && date < endDate
                    }
                    return true
                }
        }
    }
}
