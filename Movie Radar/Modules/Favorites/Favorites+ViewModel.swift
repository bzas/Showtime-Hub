//
//  FavoritesViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension FavoritesView {
    class ViewModel: ObservableObject {
        var apiService: APIService

        init(apiService: APIService) {
            self.apiService = apiService
        }
    }
}
