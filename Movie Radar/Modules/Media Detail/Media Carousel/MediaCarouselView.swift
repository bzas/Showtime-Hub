//
//  MediaCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct MediaCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    
    @State var title: String?
    @Binding var recommendationsList: MediaList
    @Binding var detailMediaToShow: Media?

    var body: some View {
        VStack {
            if let title {
                HStack {
                    Text(title)
                        .foregroundStyle(appGradient.value)
                        .font(.system(size: 20))
                    Spacer()
                }
            }

            if recommendationsList.results.isEmpty {
                NoDataAvailableView(title: NSLocalizedString("No recommendations available", comment: ""))
            } else {
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(recommendationsList.results, id: \.self) { media in
                            MediaCarouselCellView(media: media)
                                .onTapGesture {
                                    detailMediaToShow = media
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
            }
        }
    }
}
