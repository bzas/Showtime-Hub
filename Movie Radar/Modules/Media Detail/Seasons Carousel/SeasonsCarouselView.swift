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
        if let seasons = viewModel.media.seasons,
           !seasons.isEmpty {
            VStack {
                HeaderText(text: "Seasons")
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 8) {
                        ForEach(seasons, id: \.self) { season in
                            SeasonCellView(season: season)
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
