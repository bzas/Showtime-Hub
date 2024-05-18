//
//  SeasonsCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI

struct SeasonsCarouselView: View {
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    
    var body: some View {
        let seasons = Array((viewModel.media.seasons ?? []).enumerated())
        if !seasons.isEmpty {
            VStack {
                HeaderText(text: "Seasons")
                
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
                .scrollTargetBehavior(.paging)
            }
        }
    }
}

#Preview {
    SeasonsCarouselView()
}
