//
//  ActorCarousel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/4/24.
//

import SwiftUI

struct ActorCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Cast")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.mediaActors.isEmpty {
                NoDataAvailableView(title: "No cast info available")
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 20) {
                        ForEach(viewModel.mediaActors, id: \.self) { mediaActor in
                            ActorCarouselCellView(mediaActor: mediaActor)
                                .onTapGesture {
                                    viewModel.detailPersonToShow = mediaActor
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
}

#Preview {
    ActorCarouselView()
}
