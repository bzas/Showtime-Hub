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
            let keyWithoutSpaces = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)

            if !keyWithoutSpaces.isEmpty,
               LocalStorage().saveApiKey(apiKey: keyWithoutSpaces) {
                apiService.updateApiKey(keyWithoutSpaces)
                return true
            }
            return false
        }
    }
}
