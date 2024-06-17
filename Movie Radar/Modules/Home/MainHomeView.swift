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
                HomeContentView(
                    viewModel: .init(
                        apiService: apiService,
                        type: .movie
                    )
                )
                .tag(0)
                
                HomeContentView(
                    viewModel: .init(
                        apiService: apiService,
                        type: .tv
                    )
                )
                .tag(1)
            }
            .ignoresSafeArea()
            .tabViewStyle(.page)
            
            VStack {
                HStack {
                    TabViewHeader(
                        selectedTab: $selectedTab,
                        titles: [MediaType.movie, MediaType.tv].map { $0.title }
                    )
                    
                    Button(action: {
                    }, label: {
                        Image(systemName: "magnifyingglass")
                            .padding(13)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    })
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                Spacer()
            }
        }
    }
}
