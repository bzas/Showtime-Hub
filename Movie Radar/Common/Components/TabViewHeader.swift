//
//  TabViewHeader.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

enum HeaderType {
    case home, saved
}

struct TabViewHeader: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @Binding var selectedTab: Int
    var headerType: HeaderType
    
    var titles: [String]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 10) {
                ForEach(Array(titles.enumerated()), id: \.1.self) { (index, title) in
                    Button {
                        selectedTab = index
                    } label: {
                        VStack(spacing: 2) {
                            Text(title)
                                .font(.system(
                                    size: selectedTab == index ? 18 : 14)
                                )
                                .foregroundStyle(.white)
                                .opacity(selectedTab == index ? 1 : 0.5)
                                .shadow(radius: 1)
                                .padding(.horizontal, 4)
                            
                            if selectedTab == index {
                                appGradient.value
                                    .frame(width: 20, height: 2)
                                    .shadow(radius: 1)
                                    .transition(.scale)
                            }
                        }
                    }
                    .scrollTransition(.animated.threshold(.visible(0.8))) { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1 : 0.5)
                            .scaleEffect(phase.isIdentity ? 1 : 0.75)
                            .blur(radius: phase.isIdentity ? 0 : 1)
                    }
                }
                
                if headerType == .saved {
                    Spacer()
                }
            }
        }
        .scrollIndicators(.hidden)
        .sensoryFeedback(.success, trigger: selectedTab)
        .animation(
            .spring(duration: 0.3, bounce: 0),
            value: selectedTab
        )
        .frame(maxWidth: .infinity)
    }
}
