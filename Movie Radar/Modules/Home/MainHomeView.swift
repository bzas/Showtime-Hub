//
//  MainHomeView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 15/5/24.
//

import SwiftUI

struct MainHomeView: View {
    var apiService: APIService
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeContentView(viewModel: .init(apiService: apiService, type: .movie))
                    .tag(0)
                HomeContentView(viewModel: .init(apiService: apiService, type: .tv))
                    .tag(1)
            }
            .tabViewStyle(.page)
            .padding(.top, 4)
            
            TabViewHeader(
                selectedTab: $selectedTab,
                firstTitle: MediaType.movie.title,
                secondTitle: MediaType.tv.title
            )
        }
    }
}

#Preview {
    MainHomeView(apiService: APIServiceMock())
}
