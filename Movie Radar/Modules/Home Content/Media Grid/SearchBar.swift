//
//  SearchBar.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct SearchBar: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: HomeContentView.ViewModel
    @FocusState var isEditing: Bool

    var body: some View {
        HStack {
            TextField("Search...", text: $viewModel.searchText)
                .padding(7)
                .padding(.horizontal, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($isEditing)
                .onChange(of: isEditing) {
                    withAnimation {
                        viewModel.updateVisibility(isEditingSearch: isEditing)
                    }
                }

            if isEditing || !viewModel.searchText.isEmpty {
                Button(action: {
                    withAnimation {
                        isEditing = false
                        viewModel.searchText = ""
                        viewModel.updateVisibility(isEditingSearch: isEditing)
                    }
                }, label: {
                    Text("Cancel")
                        .foregroundStyle(appGradient.value)
                })
                .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 12)
    }
}
