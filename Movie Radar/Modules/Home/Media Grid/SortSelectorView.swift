//
//  SortSelectorView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import SwiftUI

struct SortSelectorView: View {
    @EnvironmentObject var viewModel: HomeContentView.ViewModel
    @State private var triggerHapticFeedback = false

    var body: some View {
        HStack {
            Text("Sort by")
                .font(.system(size: 12, weight: .light))

            Menu {
                if viewModel.type.isMovie {
                    movieSortTypes()
                } else {
                    seriesSortTypes()
                }
            } label: {
                HStack(spacing: 5) {
                    Text(viewModel.sortTitle)
                    Image(systemName: "chevron.down")
                }
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 0.5),
                trigger: viewModel.sortTitle
            )
            .tint(.white)
            .font(.system(size: 14, weight: .semibold))
            .animation(
                .spring(duration: 0.3, bounce: 0),
                value: viewModel.sortTitle
            )
            .onTapGesture {
                triggerHapticFeedback.toggle()
            }
            .sensoryFeedback(
                .impact(flexibility: .soft, intensity: 1),
                trigger: triggerHapticFeedback
            )
        }
        .disabled(viewModel.isSearching)
        .opacity(viewModel.isSearching ? 0.5 : 1)
        .padding(.top, 25)
        .padding(.trailing, 4)
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
