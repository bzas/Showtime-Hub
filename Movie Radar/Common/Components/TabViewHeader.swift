//
//  TabViewHeader.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct TabViewHeader: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @Binding var selectedTab: Int
    
    var titles: [String]

    var body: some View {
        VStack {
            HStack {
                ForEach(Array(titles.enumerated()), id: \.1.self) { (index, title) in
                    Button {
                        selectedTab = index
                    } label: {
                        VStack(spacing: 2) {
                            Text(title)
                                .font(.system(
                                    size: selectedTab == index ? 20 : 15)
                                )
                                .foregroundStyle(.white)
                                .opacity(selectedTab == index ? 1 : 0.5)
                                .shadow(radius: 1)
                            
                            if selectedTab == index {
                                appGradient.value
                                    .frame(width: 20, height: 2)
                                    .shadow(radius: 1)
                                    .transition(.scale)
                            }
                        }
                    }
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
                        .init(color: .black, location: 0.35),
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
