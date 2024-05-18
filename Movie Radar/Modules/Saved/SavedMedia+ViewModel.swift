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
        @Published var selectedPickerItem = MediaType.all
        @Published var selectedDisplayMode = GridDisplayMode.fullScreen
        @Published var movieItems: [Media] = []
        @Published var seriesItems: [Media] = []
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
        
        func items(type: SavedType) -> [Media] {
            []
        }
    }
}
