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

        @Published var isSharePresented = false
        @Published var urlToShare: URL? {
            didSet {
                isSharePresented.toggle()
            }
        }

        init(
            imageList: ImageList,
            startingIndex: Int?,
            showDetailImage: Binding<Bool>
        ) {
            self.images = imageList.transform(startIn: startingIndex ?? 0)
            self.showDetailImage = showDetailImage
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
