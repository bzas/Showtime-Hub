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
                    SavedMediaGridView(type: .favorites)
                        .environmentObject(viewModel)
                        .tag(0)
                    SavedMediaGridView(type: .viewed)
                        .environmentObject(viewModel)
                        .tag(1)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .padding(.top, 40)
            
            TabViewHeader(
                selectedTab: $selectedTab,
                firstTitle: SavedType.favorites.title,
                secondTitle: SavedType.viewed.title
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
