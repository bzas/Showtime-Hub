//
//  ImageLoader.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 12/6/24.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: Image?
    @Published var loadingFailed = false

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
        
        guard let url else {
            loadingFailed = true
            return
        }

        task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            
            guard let data,
                  error == nil else {
                loadingFailed = true
                return
            }
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else { return }
                
                self.image = Image(uiImage: uiImage)
                ImageCache.shared.set(
                    uiImage, 
                    forKey: self.key
                )
            }
        }
        task?.resume()
    }
}
