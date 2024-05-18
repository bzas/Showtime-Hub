//
//  SavedMedia+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension SavedMediaView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Published var selectedPickerItem = MediaType.all
        @Published var selectedDisplayMode = GridDisplayMode.fullScreen

        init(apiService: APIService) {
            self.apiService = apiService
        }
    }
}
