//
//  SettingsView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct SettingsView: View {
    @State var viewModel: ViewModel

    var body: some View {
        List {
            Text("Settings")
        }
    }
}

#Preview {
    SettingsView(
        viewModel: .init(
            apiService: APIServiceMock()
        )
    )
}
