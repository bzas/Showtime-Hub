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
                        Text(title)
                            .font(.system(
                                size: selectedTab == index ? 25 : 16)
                            )
                            .foregroundStyle(appGradient.value)
                            .opacity(selectedTab == index ? 0.8 : 0.4)
                            .shadow(radius: 1)
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
