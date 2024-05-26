//
//  MediaCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 25/4/24.
//

import SwiftUI
import SwiftData

struct MediaCarouselView: View {
    @EnvironmentObject var viewModel: HomeContentView.ViewModel
    let type: MediaCarouselType
    
    @Query(sort: [
        SortDescriptor(\SavedMedia.detail.name)
    ]) var savedItems: [SavedMedia]

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.horizontal) {
            let movies = viewModel.upcomingList.results
            if movies.isEmpty {
                PlaceholderView()
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.width / 1.778
                    )
            } else {
                LazyHGrid(rows: rows, spacing: 0) {
                    ForEach(movies, id: \.self) { media in
                        MediaCarouselCellView(media: media)
                            .onTapGesture {
                                viewModel.detailMediaToShow = media
                            }
                            .contextMenu {
                                MediaContextMenu(
                                    media: media,
                                    mediaType: viewModel.type,
                                    mediaItems: savedItems
                                )
                            }
                    }
                }
                .scrollTargetLayout()
            }
        }
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.hidden)
        .padding(.bottom)
    }
}
