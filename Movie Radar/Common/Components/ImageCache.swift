//
//  ImageCache.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 12/6/24.
//

import UIKit
import SwiftUI

struct CachedItem {
    let key: String
    let media: Media
}

class ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func set(_ image: UIImage?, forKey key: String) {
        if let image {
            cache.setObject(image, forKey: key as NSString)
        }
    }
    
    func get(key: String) -> Image? {
        guard let uiImage = cache.object(forKey: key as NSString) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
    
    func load(url: URL?) async -> UIImage? {
        guard let url,
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    
    func load(items: [CachedItem]) async {
        await withTaskGroup(of: (UIImage?.self)) { taskGroup in
            for item in items {
                taskGroup.addTask { [weak self] in
                    await self?.load(item)
                }
            }
        }
    }
    
    func load(_ item: CachedItem) async -> UIImage? {
        let image = await load(url: item.media.posterImageUrl)
        set(
            image,
            forKey: item.key
        )
        
        return image
    }
}
