//
//  SettingsViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation
import UIKit

extension SettingsView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        let contactMail = "mailto:bzas.developer@gmail.com"

        @Published var selectedIcon: AppIcon {
            didSet {
                changeIcon(selectedIcon)
            }
        }

        var appVersion: String? {
            Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        }

        init(apiService: APIService) {
            self.apiService = apiService
            if let iconName = UIApplication.shared.alternateIconName,
               let appIcon = AppIcon(rawValue: iconName) {
                self.selectedIcon = appIcon
            } else {
                self.selectedIcon = .AppIcon
            }
        }

        private func changeIcon(_ icon: AppIcon) {
            Task { @MainActor in
                do {
                    let iconPath = icon == .AppIcon ? nil : icon.rawValue
                    try await UIApplication.shared.setAlternateIconName(iconPath)
                } catch {
                    print(error)
                }
            }
        }
    }
}
