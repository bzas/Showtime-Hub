//
//  AppIconPickerView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 8/5/24.
//

import SwiftUI

struct AppIconPickerView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: SettingsView.ViewModel

    var body: some View {
        VStack {
            HStack {
                Text("App icon")
                Spacer()
            }

            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(AppIcon.allCases, id: \.self) { icon in
                        ZStack {
                            if viewModel.selectedIcon == icon {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(
                                        appGradient.value,
                                        lineWidth: 1
                                    )
                                    .frame(width: 80, height: 80)
                            }

                            Image(icon.path)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                        .frame(width: 85, height: 85)
                        .onTapGesture {
                            viewModel.selectedIcon = icon
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 4)
    }
}

#Preview {
    AppIconPickerView()
}
