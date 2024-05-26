//
//  SavedMediaView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import SwiftData

struct SavedMediaView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @StateObject var viewModel: ViewModel
    @State var headerHeight: CGFloat = 0

    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(Array(SavedType.allCases.enumerated()), id: \.1.self) { (index, savedType) in
                    SavedMediaGridView(
                        viewModel: viewModel,
                        type: savedType,
                        headerHeight: $headerHeight
                    )
                    .tag(index)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                HStack(spacing: 0) {
                    TabViewHeader(
                        selectedTab: $viewModel.selectedTab,
                        headerType: .saved, 
                        titles: SavedType.allCases.map { $0.title }
                    )
                    
                    HStack(spacing: 12) {
                        SavedMediaItemCount(viewModel: viewModel)
                        
                        Button {
                            viewModel.showFilters.toggle()
                        } label: {
                            Image(systemName: viewModel.filtersApplied ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(appGradient.value)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.bottom, 8)
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                .background(.ultraThinMaterial)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                headerHeight = proxy.size.height
                            }
                    }
                )

                Spacer()
            }
        }
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
                viewModel: .init(
                    gridSearchText: $viewModel.searchText,
                    filtersApplied: $viewModel.filtersApplied,
                    startDate: $viewModel.startDate,
                    endDate: $viewModel.endDate,
                    selectedMediaType: $viewModel.selectedMediaType
                )
            )
        }
    }
}
