//
//  SearchBar.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
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
                    viewModel.updatePopularVisibility(isEditingSearch: isEditing)
                }

            if isEditing || !viewModel.searchText.isEmpty {
                Button(action: {
                    isEditing = false
                    viewModel.searchText = ""
                    viewModel.updatePopularVisibility(isEditingSearch: isEditing)
                }, label: {
                    Text("Cancel")
                })
                .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 12)
    }
}
