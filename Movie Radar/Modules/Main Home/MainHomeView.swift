//
//  MainHomeView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 15/5/24.
//

import SwiftUI

struct MainHomeView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
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
            
            VStack {
                HStack {
                    Button {
                        selectedTab = 0
                    } label: {
                        Text(MediaType.movie.title)
                            .font(.system(
                                size: selectedTab == 0 ? 25 : 16)
                            )
                            .foregroundStyle(appGradient.value)
                            .opacity(selectedTab == 0 ? 0.8 : 0.4)
                            .shadow(radius: 1)
                    }
                    
                    Button {
                        selectedTab = 1
                    } label: {
                        Text(MediaType.tv.title)
                            .font(.system(
                                size: selectedTab == 1 ? 25 : 16)
                            )
                            .foregroundStyle(appGradient.value)
                            .opacity(selectedTab == 1 ? 0.8 : 0.4)
                            .shadow(radius: 1)
                    }
                }
                .sensoryFeedback(.success, trigger: selectedTab)
                .animation(
                    .spring(duration: 0.3, bounce: 0),
                    value: selectedTab
                )
                .frame(maxWidth: .infinity)
                .padding(.bottom, 8)
                .background(
                    LinearGradient(
                        stops: [
                            .init(color: .black, location: 0.3),
                            .init(color: .clear, location: 1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                Spacer()
            }
        }
    }
}

#Preview {
    MainHomeView(apiService: APIServiceMock())
}
