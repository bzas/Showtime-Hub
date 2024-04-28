//
//  TokenRequest+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import SwiftUI

extension TokenRequestView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Published var apiKey = ""

        init(apiService: APIService) {
            self.apiService = apiService
        }

        func storeKey() -> Bool {
            if !apiKey.isEmpty,
               KeychainManager().saveApiKey(apiKey: apiKey) {
                apiService.updateApiKey(apiKey)
                return true
            }
            return false
        }
    }
}
