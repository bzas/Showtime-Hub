//
//  ContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import SwiftUI

struct MainTabView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .bluePurple
    private var apiService = APIService()

    var body: some View {
        TabView {
            MainHomeView(apiService: apiService)
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "house"
                    )
                }

            FavoritesView(viewModel: .init(apiService: apiService))
                .tabItem {
                    Label(
                        "Favorites",
                        systemImage: "heart"
                    )
                }

            SettingsView(viewModel: .init(apiService: apiService))
                .tabItem {
                    Label(
                        "Settings",
                        systemImage: "gearshape"
                    )
                }
        }
        .tint(appGradient.plainColor)
    }
}

#Preview {
    MainTabView()
}
