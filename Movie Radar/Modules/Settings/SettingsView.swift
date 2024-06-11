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
    }
}
