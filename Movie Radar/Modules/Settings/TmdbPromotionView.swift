//
//  TmdbPromotionView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/5/24.
//

import SwiftUI

struct TmdbPromotionView: View {
    @EnvironmentObject var viewModel: SettingsView.ViewModel

    var body: some View {
        HStack {
            Spacer()
            Link(destination: URL(string: viewModel.databaseUrl)!,
                 label: {
                Image("tmdbLogo")
                    .resizable()
                    .scaledToFit()
                    .padding()
            })
            Spacer()
        }
    }
}

#Preview {
    TmdbPromotionView()
}
