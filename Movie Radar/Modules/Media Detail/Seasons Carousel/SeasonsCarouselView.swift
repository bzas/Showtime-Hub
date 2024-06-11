//
//  SeasonsCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct SeasonsCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    
    var body: some View {
        let seasons = Array((viewModel.media.seasons ?? []).enumerated())
        if !seasons.isEmpty {
            VStack {
                HStack {
                    Text("Seasons")
                        .foregroundStyle(appGradient.value)
                        .font(.system(size: 20))
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach(seasons, id: \.1.self) { (index, season) in
                            SeasonCellView(season: season)
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.seasonIndexToShow = index
                                    }
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
            }
            .padding(.bottom)
        }
    }
}
