//
//  MediaCrewView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 17/5/24.
//

import SwiftUI

struct MediaCrewView: View {
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 8) {
                ForEach(viewModel.productionCrew, id: \.self) { crew in
                    MediaCrewCellView(
                        name: crew.name,
                        image: crew.imageUrl,
                        role: viewModel.type.isMovie ? "Director" : "Creator"
                    )
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
    }
}
