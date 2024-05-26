//
//  FiltersView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 22/5/24.
//

import SwiftUI

struct FiltersView: View {    
    @Environment(\.dismiss) var dismiss
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white

    @State var searchText: String
    @State var startDate: Date
    @State var endDate: Date
    @State var selectedMediaType: MediaType
    @FocusState var searchFocused: Bool
    
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

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                HeaderText(text: "Filters")
                
                Button {
                    applyFilters()
                } label: {
                    Text("Reset")
                        .padding(8)
                        .foregroundStyle(.black)
                        .background(appGradient.value)
                        .font(.system(size: 14))
                        .cornerRadius(10)
                }
                .disabled(!filtersApplied.wrappedValue)
                .opacity(filtersApplied.wrappedValue ? 1 : 0)
                
                Button {
                    applyFilters(
                        searchText: searchText,
                        startDate: startDate,
                        endDate: endDate,
                        selectedMediaType: selectedMediaType
                    )
                } label: {
                    Text("Apply")
                        .font(.system(size: 14))
                        .foregroundStyle(appGradient.value)
                }
            }
            
            VStack(spacing: 20) {
                MediaPickerView(selectedMediaType: $selectedMediaType)
                
                VStack(spacing: 6) {
                    HStack {
                        Text("Search keyword")
                        Spacer()
                    }
                    
                    TextField("Write any title...", text: $searchText)
                        .padding(10)
                        .background(UIColor.systemGray5.color)
                        .cornerRadius(10)
                        .focused($searchFocused)
                        .onTapGesture {
                            searchFocused = true
                        }
                }
                
                VStack(spacing: 6) {
                    HStack {
                        Text("Released between")
                        Spacer()
                    }
                    
                    HStack(spacing: 6) {
                        DatePicker(
                            selection: $startDate,
                            in: ...Date.now,
                            displayedComponents: .date
                        ) {}
                            .labelsHidden()
                            .environment(\.locale, Locale.current)

                        Text("and")
                            .font(.system(size: 14))
                        
                        DatePicker(
                            selection: $endDate,
                            in: ...Date.now,
                            displayedComponents: .date
                        ) {}
                            .labelsHidden()
                            .environment(\.locale, Locale.current)
                        
                        Spacer()
                    }
                }
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
    }
    
    func applyFilters(
        searchText: String = "",
        startDate: Date = LocalStorage.defaultDate,
        endDate: Date = LocalStorage.defaultEndDate,
        selectedMediaType: MediaType = .all
    ) {
        gridSearchText.wrappedValue = searchText
        gridStartDate.wrappedValue = startDate
        gridEndDate.wrappedValue = endDate
        gridSelectedMediaType.wrappedValue = selectedMediaType
        updateApplied()
        dismiss()
    }
    
    func updateApplied() {
        filtersApplied.wrappedValue = !gridSearchText.wrappedValue.isEmpty ||
        gridStartDate.wrappedValue != LocalStorage.defaultDate ||
        gridEndDate.wrappedValue != LocalStorage.defaultEndDate ||
        gridSelectedMediaType.wrappedValue != .all
    }
}
