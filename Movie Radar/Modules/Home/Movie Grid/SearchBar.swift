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
                    viewModel.updateUpcomingVisibility(isEditingSearch: isEditing)
                }

            if isEditing || !viewModel.searchText.isEmpty {
                Button(action: {
                    withAnimation {
                        isEditing = false
                        viewModel.searchText = ""
                    }
                    viewModel.updateUpcomingVisibility(isEditingSearch: isEditing)
                }, label: {
                    Text("Cancel")
                        .foregroundStyle(LinearGradient.appGradient)
                })
                .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 12)
    }
}
