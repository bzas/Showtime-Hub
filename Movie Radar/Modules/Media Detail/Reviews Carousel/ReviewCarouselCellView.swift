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
        VStack(spacing: 8) {
            HStack {
                Text(review.author ?? "Anonymous")
                    .font(.system(size: 12, weight: .bold))
                    .lineLimit(2)
                Spacer()
            }

            Text(review.content ?? "")
                .lineLimit(10)
                .font(.system(size: 12))
                .padding(.horizontal, 4)
            
            Spacer()
        }
        .frame(width: 275, height: 100)
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(UIColor.systemGray5.color)
    }
}
