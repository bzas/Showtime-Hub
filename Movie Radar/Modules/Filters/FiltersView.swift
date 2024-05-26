//
//  FiltersView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 22/5/24.
//

import SwiftUI

struct FiltersView: View {    
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @FocusState var searchFocused: Bool

    var body: some View {
        VStack {
            HStack(spacing: 12) {
                HeaderText(text: "Filters")
                
                Button {
                    viewModel.applyFilters(reset: true)
                    dismiss()
                } label: {
                    Text("Reset")
                        .padding(8)
                        .foregroundStyle(.black)
                        .background(appGradient.value)
                        .font(.system(size: 14))
                        .cornerRadius(10)
                }
                .disabled(!viewModel.filtersApplied.wrappedValue)
                .opacity(viewModel.filtersApplied.wrappedValue ? 1 : 0)
                
                Button {
                    viewModel.applyFilters()
                    dismiss()
                } label: {
                    Text("Apply")
                        .font(.system(size: 14))
                        .foregroundStyle(appGradient.value)
                }
            }
            
            VStack(spacing: 20) {
                MediaPickerView(selectedMediaType: $viewModel.selectedMediaType)
                
                VStack(spacing: 6) {
                    HStack {
                        Text("Search keyword")
                        Spacer()
                    }
                    
                    TextField("Write any title...", text: $viewModel.searchText)
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
                            selection: $viewModel.startDate,
                            in: ...Date.now,
                            displayedComponents: .date
                        ) {}
                            .labelsHidden()
                            .environment(\.locale, Locale.current)

                        Text("and")
                            .font(.system(size: 14))
                        
                        DatePicker(
                            selection: $viewModel.endDate,
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
}
