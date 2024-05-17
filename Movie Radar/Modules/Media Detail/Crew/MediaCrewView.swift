//
//  MediaCrewView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 17/5/24.
//

import SwiftUI

struct MediaCrewView: View {
    let type: MediaType
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    
    var body: some View {
        if type.isMovie {
            MediaCrewCellView(
                name: viewModel.director?.name,
                role: "Director",
                image: viewModel.director?.imageUrl
            )
        } else {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(viewModel.media.creators ?? [], id: \.self) { creator in
                        MediaCrewCellView(
                            name: creator.name,
                            role: "Creator",
                            image: creator.imageUrl
                        )
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.paging)
        }
    }
}

#Preview {
    MediaCrewView(type: .movie)
}
