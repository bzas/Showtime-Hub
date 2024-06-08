//
//  ReviewDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/5/24.
//

import SwiftUI

struct ReviewDetailView: View {
    @StateObject var viewModel: ViewModel
    let rows = [
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 8) {
                Spacer()
                ScrollView(.horizontal) {
                    LazyHGrid(rows: rows) {
                        ForEach(Array(viewModel.reviews.enumerated()), id: \.1.self) { (index, review) in
                                VStack {
                                    Text(review.author ?? "Anonymous")
                                        .font(.system(size: 18, weight: .semibold))
                                    ScrollView {
                                        Text(review.content ?? "")
                                            .font(.system(size: 14, weight: .light))
                                    }
                                }
                                .padding()
                                .frame(
                                    width: proxy.size.width / 1.25,
                                    height: proxy.size.height / 1.75
                                )
                                .background(UIColor.systemGray5.color)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                            .scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.6)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.75)
                                    .blur(radius: phase.isIdentity ? 0 : 2)
                            }
                        }
                    }
                    .padding(.horizontal, (proxy.size.width - (proxy.size.width / 1.25)) / 2)
                    .scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .scrollIndicators(.hidden)
                Spacer()
            }
            .background(.clear)
            .onTapGesture {
                viewModel.showDetail = false
            }
        }
    }
}
