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
                HomeContentView(viewModel: .init(apiService: apiService))
                    .tag(0)
                HomeContentView(viewModel: .init(apiService: apiService))
                    .tag(1)
            }
            .tabViewStyle(.page)
            
            VStack {
                HStack {
                    Text("Movies")
                        .font(.system(
                            size: selectedTab == 0 ? 35 : 18,
                            weight: selectedTab == 0 ? .heavy : .regular)
                        )
                        .foregroundStyle(appGradient.value)
                        .opacity(selectedTab == 0 ? 0.6 : 0.4)
                    Text("Series")
                        .font(.system(
                            size: selectedTab == 1 ? 35 : 18,
                            weight: selectedTab == 1 ? .heavy : .regular)
                        )
                        .foregroundStyle(appGradient.value)
                        .opacity(selectedTab == 1 ? 0.6 : 0.4)
                }
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [.black, .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                Spacer()
            }
            .disabled(true)
        }
    }
}

#Preview {
    MainHomeView(apiService: APIServiceMock())
}
