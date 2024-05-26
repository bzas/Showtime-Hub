//
//  Filters+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/5/24.
//

import SwiftUI

extension FiltersView {
    class ViewModel: ObservableObject {
        @Published var searchText: String
        @Published var startDate: Date
        @Published var endDate: Date
        @Published var selectedMediaType: MediaType
        
        var dateFilterApplied = false
        
        var gridSearchText: Binding<String>
        var filtersApplied: Binding<Bool>
        var gridStartDate: Binding<Date>
        var gridEndDate: Binding<Date>
        var gridSelectedMediaType: Binding<MediaType>

        init(
            gridSearchText: Binding<String>,
            filtersApplied: Binding<Bool>,
            startDate: Binding<Date>,
            endDate: Binding<Date>,
            selectedMediaType: Binding<MediaType>
        ) {
            self.searchText = gridSearchText.wrappedValue
            self.startDate = startDate.wrappedValue
            self.endDate = endDate.wrappedValue
            self.selectedMediaType = selectedMediaType.wrappedValue
            
            self.gridSearchText = gridSearchText
            self.filtersApplied = filtersApplied
            self.gridStartDate = startDate
            self.gridEndDate = endDate
            self.gridSelectedMediaType = selectedMediaType
        }
        
        func applyFilters(reset: Bool = false) {
            if reset {
                gridSearchText.wrappedValue = ""
                gridStartDate.wrappedValue = LocalStorage.defaultDate
                gridEndDate.wrappedValue = LocalStorage.defaultEndDate
                gridSelectedMediaType.wrappedValue = .all
            } else {
                gridSearchText.wrappedValue = searchText
                gridStartDate.wrappedValue = startDate
                gridEndDate.wrappedValue = endDate
                gridSelectedMediaType.wrappedValue = selectedMediaType
            }
            updateApplied()
        }
        
        func updateApplied() {
            filtersApplied.wrappedValue = !gridSearchText.wrappedValue.isEmpty ||
            gridStartDate.wrappedValue != LocalStorage.defaultDate ||
            gridEndDate.wrappedValue != LocalStorage.defaultEndDate ||
            gridSelectedMediaType.wrappedValue != .all
        }
    }
}
