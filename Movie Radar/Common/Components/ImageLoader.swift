//
//  ImageLoader.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 12/6/24.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image?

    private var url: URL?
    private var key: String
    private var task: URLSessionDataTask?

    init(key: String, url: URL?) {
        self.url = url
        self.key = key
        loadImage()
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(key: key) {
            self.image = cachedImage
            return
        }
        
        guard let url else { return }

        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async { [weak self] in
                guard let self,
                      let uiImage = UIImage(data: data) else { return }
                
                image = Image(uiImage: uiImage)
                ImageCache.shared.set(uiImage, forKey: key)
            }
        }
        task?.resume()
    }
}
