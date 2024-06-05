//
//  ProviderCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/6/24.
//

import SwiftUI

struct ProviderCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Watch on")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            let providerImageList = (viewModel.watchInfo?.all ?? [])
                .sorted { ($0.displayPriority ?? 0) < ($1.displayPriority ?? 0) }
                .compactMap { $0.imagePath }
            let providerImageListFiltered = Array(Set(providerImageList))
            
            if providerImageListFiltered.isEmpty {
                NoDataAvailableView(title: NSLocalizedString("No providers available", comment: ""))
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 25) {
                        ForEach(providerImageListFiltered, id: \.self) { providerImage in
                            ProviderCarouselCellView(imagePath: providerImage)
                        }
                    }
                }
            }
        }
        .padding(.top)
    }
}

#Preview {
    ProviderCarouselView()
}
