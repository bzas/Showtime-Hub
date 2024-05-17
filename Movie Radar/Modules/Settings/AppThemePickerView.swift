//
//  AppThemePickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 8/5/24.
//

import SwiftUI

struct AppThemePickerView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white

    var body: some View {
        VStack {
            HStack {
                Text("Theme")
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(AppGradient.allCases, id: \.self) { gradient in
                        ZStack {
                            if gradient == appGradient {
                                Circle()
                                    .stroke(
                                        appGradient.value,
                                        lineWidth: 1
                                    )
                                    .frame(width: 90, height: 90)
                            }

                            gradient.value
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                        }
                        .frame(width: 95, height: 95)
                        .onTapGesture {
                            appGradient = gradient
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    AppThemePickerView()
}
