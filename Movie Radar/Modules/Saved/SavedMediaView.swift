//
//  SavedMediaView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import SwiftData

struct SavedMediaView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(Array(SavedType.allCases.enumerated()), id: \.1.self) { (index, savedType) in
                    SavedMediaGridView(
                        viewModel: viewModel,
                        type: savedType
                    )
                    .tag(index)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                VStack(spacing: 0) {
                    TabViewHeader(
                        selectedTab: $viewModel.selectedTab,
                        titles: SavedType.allCases.map { $0.title }
                    )
                    .padding(.bottom, 4)
                    
                    SavedMediaFiltersView(selectedTab: $viewModel.selectedTab)
                        .environmentObject(viewModel)
                }
                .background(.ultraThinMaterial)

                Spacer()
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .fullScreenCover(isPresented: $viewModel.showDetailMedia) {
            if let detailMediaToShow = viewModel.detailMediaToShow {
                MediaDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        media: detailMediaToShow.detail,
                        type: detailMediaToShow.type
                    )
                )
            }
        }
        .sheet(isPresented: $viewModel.showFilters) {
            FiltersView(
                gridSearchText: $viewModel.searchText,
                filtersApplied: $viewModel.filtersApplied,
                startDate: $viewModel.startDate,
                endDate: $viewModel.endDate
            )
        }
    }
}
