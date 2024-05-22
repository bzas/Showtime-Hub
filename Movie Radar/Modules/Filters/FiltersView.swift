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
    @FocusState var searchFocused: Bool
    
    var gridSearchText: Binding<String>
    var filtersApplied: Binding<Bool>
    
    init(gridSearchText: Binding<String>, filtersApplied: Binding<Bool>) {
        self.searchText = gridSearchText.wrappedValue
        self.gridSearchText = gridSearchText
        self.filtersApplied = filtersApplied
    }

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                HeaderText(text: "Filters")
                
                Button {
                    applyFilters(searchText: "")
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
                    applyFilters(searchText: searchText)
                } label: {
                    Text("Apply")
                        .font(.system(size: 14))
                        .foregroundStyle(appGradient.value)
                }
            }
            
            VStack(spacing: 4) {
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
            
            Spacer()
        }
        .padding()
        .presentationDetents([.medium])
    }
    
    func applyFilters(searchText: String) {
        gridSearchText.wrappedValue = searchText
        updateApplied()
        dismiss()
    }
    
    func updateApplied() {
        filtersApplied.wrappedValue = !gridSearchText.wrappedValue.isEmpty
    }
}
