//
//  SavedMediaView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct SavedMediaView: View {
    @StateObject var viewModel: ViewModel
    @State var selectedTab = 0

    var body: some View {
        ZStack {
            VStack {
                SavedMediaFiltersView()
                    .environmentObject(viewModel)

                TabView(selection: $selectedTab) {
                    SavedListView()
                        .environmentObject(viewModel)
                        .tag(0)
                    SavedListView()
                        .environmentObject(viewModel)
                        .tag(1)
                }
                .tabViewStyle(.page)
            }
            .padding(.top, 4)
            
            TabViewHeader(
                selectedTab: $selectedTab,
                firstTitle: SavedType.favorites.title,
                secondTitle: SavedType.viewed.title
            )
        }
    }
}

#Preview {
    SavedMediaView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
