//
//  SavedMediaFiltersView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaFiltersView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 12) {
            MediaPickerView()
                .environmentObject(viewModel)
            Spacer()

            SavedMediaItemCount(selectedTab: $selectedTab)
                .environmentObject(viewModel)
            
            Button {
                
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(appGradient.value)
                    .frame(width: 20, height: 20)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 6)
    }
}
