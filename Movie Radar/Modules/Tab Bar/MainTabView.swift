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
                .tabItem {
                    Label(
                        "Home",
                        systemImage: "house"
                    )
                }

            SavedMediaView(
                viewModel: .init(
                    apiService: apiService,
                    modelContext: modelContext
                )
            )
            .tabItem {
                Label(
                    "Saved",
                    systemImage: "archivebox"
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
        .tint(.white)
    }
}

#Preview {
    MainTabView()
}
