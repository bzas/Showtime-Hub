//
//  MediaDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct MediaDetailView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                MediaDetailHeaderView()
                    .environmentObject(viewModel)
                MediaDetailBodyView()
                    .environmentObject(viewModel)
            }
        }
        .scrollIndicators(.hidden)
        .fullScreenCover(isPresented: $viewModel.showDetailMedia) {
            if let detailMediaToShow = viewModel.detailMediaToShow {
                MediaDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        media: detailMediaToShow,
                        type: viewModel.type
                    )
                )
            }
        }
        .sheet(isPresented: $viewModel.showDetailPerson) {
            if let detailPersonId = viewModel.detailPersonToShow?.id {
                PersonDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        personId: detailPersonId
                    )
                )
            }
        }
        .blur(radius: (viewModel.showDetailImage || viewModel.showDetailSeason || viewModel.showDetailReview) ? 10 : 0)
        .opacity((viewModel.showDetailImage || viewModel.showDetailSeason) ? 0.6 : 1)
        .overlay {
            if networkMonitor.isDisconnected {
                NoInternetPopUpView()
            } else if viewModel.showDetailImage {
                ImageDetailView(
                    viewModel: .init(
                        imageList: viewModel.imageList,
                        startingIndex: viewModel.imageIndexToShow,
                        showDetail: $viewModel.showDetailImage
                    )
                )
            } else if viewModel.showDetailSeason {
                ImageDetailView(
                    viewModel: .init(
                        seasons: viewModel.media.seasons ?? [],
                        startingIndex: viewModel.seasonIndexToShow,
                        showDetail: $viewModel.showDetailSeason
                    )
                )
            } else if viewModel.showDetailReview {
                ReviewDetailView(
                    viewModel: .init(
                        reviewList: viewModel.reviewList,
                        startingIndex: viewModel.reviewIndexToShow,
                        showDetail: $viewModel.showDetailReview
                    )
                )
            }
        }
    }
}
