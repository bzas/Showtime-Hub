//
//  SearchBar.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var viewModel: HomeView.ViewModel
    @FocusState private var isEditing: Bool

    var body: some View {
        HStack {
            TextField("Search...", text: $viewModel.searchText)
                .padding(7)
                .padding(.horizontal, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .focused($isEditing)

            if isEditing || !viewModel.searchText.isEmpty {
                Button(action: {
                    self.isEditing = false
                    self.viewModel.searchText = ""
                }, label: {
                    Text("Cancel")
                })
                .padding(.trailing, 10)
            }
        }
        .padding(.bottom, 12)
    }
}
