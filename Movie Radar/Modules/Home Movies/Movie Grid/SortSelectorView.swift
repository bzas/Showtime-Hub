//
//  SortSelectorView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import SwiftUI

struct SortSelectorView: View {
    @EnvironmentObject var viewModel: HomeMoviesView.ViewModel

    var body: some View {
        HStack {
            Text("Sort by:")
                .font(.system(size: 12, weight: .light))

            Menu(viewModel.sortType.title) {
                ForEach(GridSortType.allCases, id: \.self) { type in
                    Button(action: {
                        withAnimation {
                            viewModel.sortType = type
                        }
                    }, label: {
                        Text(type.title)
                    })
                }
            }
            .tint(.white)
            .font(.system(size: 14, weight: .semibold))
            .buttonStyle(.bordered)
        }
        .disabled(viewModel.isSearching)
        .opacity(viewModel.isSearching ? 0.5 : 1)
    }
}

#Preview {
    SortSelectorView()
}
