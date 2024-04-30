//
//  ContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        buildUI()
            .sheet(isPresented: $viewModel.isPresentingTokenRequest) {
                TokenRequestView(
                    viewModel: .init(
                        apiService: viewModel.apiService
                    )
                )
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
    }

    @ViewBuilder
    func buildUI() -> some View {
        if viewModel.isPresentingTokenRequest {
            UIColor.systemBackground.color
                .ignoresSafeArea()
        } else {
            TabView {
                HomeView(viewModel: .init(apiService: viewModel.apiService))
                    .tabItem {
                        Label(
                            "Home",
                            systemImage: "house"
                        )
                    }

                FavoritesView(viewModel: .init(apiService: viewModel.apiService))
                    .tabItem {
                        Label(
                            "Favorites",
                            systemImage: "heart"
                        )
                    }

                SettingsView(viewModel: .init(apiService: viewModel.apiService))
                    .tabItem {
                        Label(
                            "Settings",
                            systemImage: "gearshape"
                        )
                    }
            }
            .tint(.purple)
        }
    }
}

#Preview {
    MainTabView()
}
