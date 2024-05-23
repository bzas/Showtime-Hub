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
    @FocusState var searchFocused: Bool
    
    var dateFilterApplied = false
    
    var gridSearchText: Binding<String>
    var filtersApplied: Binding<Bool>
    var gridStartDate: Binding<Date?>
    var gridEndDate: Binding<Date?>

    init(
        gridSearchText: Binding<String>,
        filtersApplied: Binding<Bool>,
        startDate: Binding<Date?>,
        endDate: Binding<Date?>
    ) {
        self.searchText = gridSearchText.wrappedValue
        self.gridSearchText = gridSearchText
        self.filtersApplied = filtersApplied
        self.gridStartDate = startDate
        self.gridEndDate = endDate
        self.startDate = startDate.wrappedValue ?? Date(timeIntervalSince1970: -2208950000)
        self.endDate = endDate.wrappedValue ?? Date.now
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
                        endDate: endDate
                    )
                } label: {
                    Text("Apply")
                        .font(.system(size: 14))
                        .foregroundStyle(appGradient.value)
                }
            }
            
            VStack(spacing: 20) {
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
                .padding(.top)
                
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

            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
    }
    
    func applyFilters(
        searchText: String = "",
        startDate: Date? = nil,
        endDate: Date? = nil
    ) {
        gridSearchText.wrappedValue = searchText
        gridStartDate.wrappedValue = startDate
        gridEndDate.wrappedValue = endDate
        updateApplied()
        dismiss()
    }
    
    func updateApplied() {
        filtersApplied.wrappedValue = !gridSearchText.wrappedValue.isEmpty ||
        gridStartDate.wrappedValue != nil ||
        gridEndDate.wrappedValue != nil
    }
}
