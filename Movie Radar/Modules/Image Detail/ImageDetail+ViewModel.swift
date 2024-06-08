//
//  ImageDetailCarousel+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 3/5/24.
//

import SwiftUI

extension ImageDetailView {
    class ViewModel: ObservableObject {
        @Binding var showDetail: Bool

        @Published var images = [ImageData]()
        @Published var isBigImage: Bool
        @Published var isSharePresented = false
        @Published var urlToShare: URL? {
            didSet {
                isSharePresented.toggle()
            }
        }

        init(
            imageList: ImageList,
            startingIndex: Int?,
            showDetail: Binding<Bool>
        ) {
            self.images = ImageData.create(
                images: imageList.posters,
                startIndex: startingIndex ?? 0
            )
            self._showDetail = showDetail
            self.isBigImage = true
        }
        
        init(
            seasons: [Season],
            startingIndex: Int?,
            showDetail: Binding<Bool>
        ) {
            self.images = ImageData.create(
                seasons: seasons,
                startIndex: startingIndex ?? 0
            )
            self._showDetail = showDetail
            self.isBigImage = false
        }

        func downloadImage(url: URL?) {
            guard let url else { return }

            Task {
                let (data, response) = try await URLSession.shared.data(from: url)
                print(response)
                saveImageToPhotos(imageData: data)
            }
        }

        func saveImageToPhotos(imageData: Data) {
            guard let image = UIImage(data: imageData) else { return }
            UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        }
    }
}
