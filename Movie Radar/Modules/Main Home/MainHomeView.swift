//
//  MainHomeView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 15/5/24.
//

import SwiftUI

struct MainHomeView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .bluePurple
    var apiService: APIService
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeMoviesView(viewModel: .init(apiService: apiService))
                    .tag(0)
                HomeSeriesView(viewModel: .init(apiService: apiService))
                    .tag(1)
            }
            .tabViewStyle(.page)
            
            VStack {
                HStack {
                    Text(selectedTab == 0 ? "Movies" : "Series")
                        .font(.system(size: 35, weight: .heavy))
                        .foregroundStyle(appGradient.value)
                        .opacity(0.3)
                    Spacer()
                }
                Spacer()
            }
            .padding(.horizontal)
            .disabled(true)
        }
    }
}

#Preview {
    MainHomeView(apiService: APIServiceMock())
}
