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
            VStack {
                SavedMediaItemCount(selectedTab: $selectedTab)
                    .environmentObject(viewModel)

                SavedMediaFiltersView()
                    .environmentObject(viewModel)
                
                TabView(selection: $selectedTab) {
                    ForEach(Array(SavedType.allCases.enumerated()), id: \.1.self) { (index, savedType) in
                        SavedMediaGridView(type: savedType)
                            .environmentObject(viewModel)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .padding(.top, 40)
            
            TabViewHeader(
                selectedTab: $selectedTab,
                titles: SavedType.allCases.map { $0.title }
            )
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
    }
}
