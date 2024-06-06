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
    
    var body: some View {
        VStack {
            HStack {
                Text("Watch now")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }
            
            HStack {
                Picker("", selection: $viewModel.selectedProviderType) {
                    ForEach(ProviderType.allCases, id: \.self) { providerType in
                        Text(providerType.title)
                    }
                }
                .pickerStyle(.segmented)
                Spacer()
            }
            .padding(.bottom, 6)
            
            let providerImageList = viewModel.selectedWatchProviders.compactMap { $0.imageUrl }
            if providerImageList.isEmpty {
                NoDataAvailableView(title: NSLocalizedString("No providers available", comment: ""))
                    .frame(height: 50)
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 25) {
                        ForEach(providerImageList, id: \.self) { providerImageUrl in
                            ProviderCarouselCellView(imageUrl: providerImageUrl)
                        }
                    }
                }
            }
        }
        .padding(.vertical)
        .padding(.bottom, 8)
    }
}

#Preview {
    ProviderCarouselView()
}
