//
//  ReviewDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 8/5/24.
//

import SwiftUI

struct ReviewDetailView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    var review: Review

    var body: some View {
        VStack {
            if let author = review.author {
                HStack {
                    Text(author)
                        .lineLimit(2)
                        .foregroundStyle(appGradient.value)
                        .font(.system(size: 24))
                    Spacer()
                }
            }

            if let content = review.content {
                ScrollView {
                    Text(content)
                        .font(.system(size: 14))
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding()
        .presentationDetents([.medium])
    }
}
