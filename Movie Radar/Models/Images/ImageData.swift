//
//  ImageData.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import Foundation

struct ImageData: Hashable {
    let imageUrl: URL?
    let name: String?
    let subtitle: String?
    let descriptionText: String?
    
    static func create(images: [MediaImage], startIndex: Int) -> [Self] {
        let imageDataArray = images.map {
            ImageData(
                imageUrl: $0.originalImageUrl,
                name: nil,
                subtitle: nil,
                descriptionText: nil
            )
        }
        
        return Self.transform(
            array: imageDataArray,
            startIn: startIndex
        )
    }
    
    static func create(seasons: [Season], startIndex: Int) -> [Self] {
        let imageDataArray = seasons.map {
            ImageData(
                imageUrl: $0.imageUrl,
                name: $0.name,
                subtitle: String(format: NSLocalizedString("%d episodes", comment: ""), $0.episodeCount ?? 0),
                descriptionText: $0.overview
            )
        }
        
        return Self.transform(
            array: imageDataArray,
            startIn: startIndex
        )
    }
    
    static func transform(array: [Self], startIn index: Int) -> [Self] {
        let subarray1 = Array(array[0..<index])
        let subarray2 = Array(array[index..<array.endIndex])
        return subarray2 + subarray1
    }
}
