//
//  ImageDetailCarousel+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 3/5/24.
//

import SwiftUI

extension ImageDetailView {
    class ViewModel: ObservableObject {
        @Published var images = [MovieImage]()
        var showDetailImage: Binding<Bool>

        init(
            imageList: ImageList,
            startingIndex: Int?,
            showDetailImage: Binding<Bool>
        ) {
            self.images = imageList.transform(startIn: startingIndex ?? 0)
            self.showDetailImage = showDetailImage
        }
    }
}
