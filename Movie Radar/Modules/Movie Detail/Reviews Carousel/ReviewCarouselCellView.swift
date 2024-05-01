//
//  ReviewsCarouselCellView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import SwiftUI

struct ReviewCarouselCellView: View {
    var review: Review

    var body: some View {
        VStack {
            HStack {
                Text(review.author ?? "Anonymous")
                    .font(.system(size: 12, weight: .bold))
                    .lineLimit(2)
                Spacer()
            }
            ScrollView {
                Text(review.content ?? "")
                    .font(.system(size: 12))
                    .padding(.horizontal, 4)
                    .padding(.bottom)
            }
        }
        .frame(maxWidth: 275, maxHeight: 200)
        .padding()
        .background(UIColor.systemGray5.color)
    }
}
