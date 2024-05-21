//
//  ReviewDetail+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 20/5/24.
//

import SwiftUI

extension ReviewDetailView {
    class ViewModel: ObservableObject {
        var showDetail: Binding<Bool>

        @Published var reviews = [Review]()

        init(
            reviewList: ReviewList,
            startingIndex: Int?,
            showDetail: Binding<Bool>
        ) {
            self.reviews = reviewList.transform(startIn: startingIndex ?? 0)
            self.showDetail = showDetail
        }
    }
}