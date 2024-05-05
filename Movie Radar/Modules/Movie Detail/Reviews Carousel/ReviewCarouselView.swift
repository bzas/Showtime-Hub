//
//  ReviewsCarouselView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct ReviewCarouselView: View {
    @EnvironmentObject var viewModel: MovieDetailView.ViewModel
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            HStack {
                Text("Reviews")
                    .foregroundStyle(LinearGradient.appGradient)
                    .font(.system(size: 20))
                Spacer()
            }

            if viewModel.reviewList.reviews.isEmpty {
                NoDataAvailableView(title: "No reviews available")
            } else {
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows, spacing: 12) {
                        ForEach(viewModel.reviewList.reviews, id: \.self) { review in
                            ReviewCarouselCellView(review: review)
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
