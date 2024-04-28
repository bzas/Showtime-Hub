//
//  MainTabView+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 28/4/24.
//

import Foundation

extension MainTabView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Published var isPresentingTokenRequest: Bool

        init() {
            if let apiKey = LocalStorage().retrieveApiKey() {
                apiService = APIService(apiKey: apiKey)
                isPresentingTokenRequest = false
            } else {
                apiService = APIService()
                isPresentingTokenRequest = true
            }
        }
    }
}
