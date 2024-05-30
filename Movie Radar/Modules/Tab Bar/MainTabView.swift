//
//  ContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @Environment(\.modelContext) var modelContext
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    private var apiService = APIService()

    var body: some View {
        ZStack {
            TabView {
                MainHomeView(apiService: apiService)
                    .customizeTabItem(
                        name: NSLocalizedString("Discover", comment: ""),
                        imageName: "house"
                    )

                SavedMediaView(
                    viewModel: .init(
                        apiService: apiService,
                        modelContext: modelContext
                    )
                )
                .customizeTabItem(
                    name: NSLocalizedString("Saved", comment: ""),
                    imageName: "archivebox"
                )

                SettingsView(viewModel: .init(apiService: apiService))
                    .customizeTabItem(
                        name: NSLocalizedString("Settings", comment: ""),
                        imageName: "gearshape"
                    )
            }
            .tint(.white)
            
            if networkMonitor.isDisconnected {
                NoInternetPopUpView()
            }
        }
    }
}
