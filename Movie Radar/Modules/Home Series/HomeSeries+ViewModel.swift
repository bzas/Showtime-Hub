//
//  HomeSeries+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 15/5/24.
//

import Foundation

extension HomeSeriesView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        
        init(apiService: APIService) {
            self.apiService = apiService
        }
    }
}
