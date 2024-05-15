//
//  AppVersionView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 10/5/24.
//

import SwiftUI

struct AppVersionView: View {
    var appVersion: String?

    var body: some View {
        if let appVersion {
            HStack {
                Text("Version")
                Spacer()
                Text(appVersion)
                    .foregroundStyle(.gray)
                    .fontWeight(.light)
                    .frame(minWidth: 30)
            }
        }
    }
}

#Preview {
    AppVersionView(appVersion: "1.0.0")
}
