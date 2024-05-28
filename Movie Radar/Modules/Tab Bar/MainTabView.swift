//
//  ContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.modelContext) var modelContext
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    private var apiService = APIService()

    var body: some View {
        TabView {
            MainHomeView(apiService: apiService)
                .customizeTabItem(
                    name: "Home",
                    imageName: "house"
                )

            SavedMediaView(
                viewModel: .init(
                    apiService: apiService,
                    modelContext: modelContext
                )
            )
            .customizeTabItem(
                name: "Saved",
                imageName: "archivebox"
            )

            SettingsView(viewModel: .init(apiService: apiService))
                .customizeTabItem(
                    name: "Settings",
                    imageName: "gearshape"
                )
        }
        .tint(.white)
    }
}
