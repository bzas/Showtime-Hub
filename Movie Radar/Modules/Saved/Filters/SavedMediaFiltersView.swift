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
        HStack(spacing: 0) {
            MediaPickerView()
                .environmentObject(viewModel)
            
            Spacer()

            HStack(spacing: 12) {
                SavedMediaItemCount(
                    viewModel: viewModel,
                    selectedTab: $selectedTab
                )
                
                Button {
                    viewModel.showFilters.toggle()
                } label: {
                    Image(systemName: viewModel.filtersApplied ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(appGradient.value)
                        .frame(width: 20, height: 20)
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 6)
    }
}
