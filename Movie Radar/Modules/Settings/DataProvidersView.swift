//
//  DataProvidersView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/5/24.
//

import SwiftUI

struct DataProvidersView: View {
    @EnvironmentObject var viewModel: SettingsView.ViewModel

    var body: some View {
        HStack {
            Image("tmdbLogo")
                .resizable()
                .scaledToFit()
                .padding()
                .clipped()
            
            Image("justWatchLogo")
                .resizable()
                .scaledToFit()
                .padding()
                .padding()
                .clipped()
        }
    }
}
