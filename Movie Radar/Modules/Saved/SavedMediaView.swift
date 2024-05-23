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
    @State var selectedTab = 0

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                ForEach(Array(SavedType.allCases.enumerated()), id: \.1.self) { (index, savedType) in
                    SavedMediaGridView(type: savedType)
                        .environmentObject(viewModel)
                        .tag(index)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                VStack(spacing: 0) {
                    TabViewHeader(
                        selectedTab: $selectedTab,
                        titles: SavedType.allCases.map { $0.title }
                    )
                    .padding(.bottom, 4)
                    
                    SavedMediaFiltersView(selectedTab: $selectedTab)
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
