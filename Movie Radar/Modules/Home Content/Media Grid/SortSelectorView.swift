//
//  SortSelectorView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import SwiftUI

struct SortSelectorView: View {
    @EnvironmentObject var viewModel: HomeContentView.ViewModel

    var body: some View {
        HStack {
            Text("Sort by")
                .font(.system(size: 12, weight: .light))

            Menu(viewModel.sortTitle) {
                if viewModel.type.isMovie {
                    movieSortTypes()
                } else {
                    seriesSortTypes()
                }
            }
            .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: viewModel.sortTitle)
            .tint(.white)
            .font(.system(size: 14, weight: .semibold))
            .buttonStyle(.bordered)
        }
        .disabled(viewModel.isSearching)
        .opacity(viewModel.isSearching ? 0.5 : 1)
        .if(viewModel.type == .tv) { view in
            view.padding(.top, 35)
        }
    }
    
    @ViewBuilder
    func movieSortTypes() -> some View {
        ForEach(MovieGridSortType.allCases, id: \.self) { type in
            Button(action: {
                withAnimation {
                    viewModel.movieSortType = type
                }
            }, label: {
                Text(type.title)
            })
        }
    }
    
    @ViewBuilder
    func seriesSortTypes() -> some View {
        ForEach(SeriesGridSortType.allCases, id: \.self) { type in
            Button(action: {
                withAnimation {
                    viewModel.seriesSortType = type
                }
            }, label: {
                Text(type.title)
            })
        }
    }
}

#Preview {
    SortSelectorView()
}
