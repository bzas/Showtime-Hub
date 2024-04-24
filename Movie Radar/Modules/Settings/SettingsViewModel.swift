//
//  SettingsViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension SettingsView {
    @Observable
    class ViewModel {
        var apiService: APIService

        init(apiService: APIService) {
            self.apiService = apiService
        }
    }
}

