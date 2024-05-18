//
//  SavedMediaFiltersView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaFiltersView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel

    var body: some View {
        VStack {
            HStack {
                MediaPickerView()
                    .environmentObject(viewModel)
                Spacer()
                DisplaySelectorView()
                    .environmentObject(viewModel)
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.top, 50)
    }
}

#Preview {
    SavedMediaFiltersView()
}
