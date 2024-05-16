//
//  MediaDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

struct MediaDetailView: View {
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
        .sheet(isPresented: $viewModel.showDetailReview) {
            if let detailReview = viewModel.detailReviewToShow {
                ReviewDetailView(review: detailReview)
            }
        }
        .blur(radius: viewModel.showDetailImage ? 10 : 0)
        .overlay {
            if viewModel.showDetailImage {
                ImageDetailView(
                    viewModel: .init(
                        imageList: viewModel.imageList,
                        startingIndex: viewModel.imageIndexToShow,
                        showDetailImage: $viewModel.showDetailImage
                    )
                )
            }
        }
    }
}