//
//  ReviewsCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct ReviewCarouselView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Reviews")
                    .foregroundStyle(appGradient.value)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.reviewList.reviews.isEmpty {
                NoDataAvailableView(title: NSLocalizedString("No reviews available", comment: ""))
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 12) {
                        ForEach(Array(viewModel.reviewList.reviews.enumerated()), id: \.1.self) { (index, review) in
                            ReviewCarouselCellView(review: review)
                                .onTapGesture {
                                    viewModel.reviewIndexToShow = index
                                }
                        }
                    }
                    .scrollTargetLayout()
                }
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.viewAligned)
            }
        }
        .padding(.bottom)
    }
}

#Preview {
    ReviewCarouselView()
}
