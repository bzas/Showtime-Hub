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
    @State var headerHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeContentView(
                    headerHeight: $headerHeight,
                    viewModel: .init(
                        apiService: apiService,
                        type: .movie
                    )
                )
                .tag(0)
                
                HomeContentView(
                    headerHeight: $headerHeight,
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
                TabViewHeader(
                    selectedTab: $selectedTab,
                    headerType: .home,
                    titles: [MediaType.movie, MediaType.tv].map { $0.title }
                )
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                headerHeight = proxy.size.height
                            }
                    }
                )
                Spacer()
            }
        }
    }
}
