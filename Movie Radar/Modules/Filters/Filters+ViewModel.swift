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
        
        @Binding var gridSearchText: String
        @Binding var filtersApplied: Bool
        @Binding var gridStartDate: Date
        @Binding var gridEndDate: Date
        @Binding var gridSelectedMediaType: MediaType

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
            
            self._gridSearchText = gridSearchText
            self._filtersApplied = filtersApplied
            self._gridStartDate = startDate
            self._gridEndDate = endDate
            self._gridSelectedMediaType = selectedMediaType
        }
        
        func applyFilters(reset: Bool = false) {
            if reset {
                gridSearchText = ""
                gridStartDate = LocalStorage.defaultDate
                gridEndDate = LocalStorage.defaultEndDate
                gridSelectedMediaType = .all
            } else {
                gridSearchText = searchText
                gridStartDate = startDate
                gridEndDate = endDate
                gridSelectedMediaType = selectedMediaType
            }
            updateApplied()
        }
        
        func updateApplied() {
            filtersApplied = !gridSearchText.isEmpty ||
            gridStartDate != LocalStorage.defaultDate ||
            gridEndDate != LocalStorage.defaultEndDate ||
            gridSelectedMediaType != .all
        }
    }
}
