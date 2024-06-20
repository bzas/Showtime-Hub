//
//  SettingsView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        List {
            HStack {
                Image("appLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                Spacer()
            }
            .listRowBackground(Color.clear)
            
            Section(header: Text("Personalization")) {
                AppIconPickerView()
                    .environmentObject(viewModel)

                AppThemePickerView()
            }

            Section(header: Text("About")) {
                ContactView()
                    .environmentObject(viewModel)
                RateView()
                AppVersionView(appVersion: viewModel.appVersion)
            }

            Section(header: Text("Powered by")) {
                DataProvidersView()
                    .environmentObject(viewModel)
            }
        }
        .scrollIndicators(.hidden)
    }
}
