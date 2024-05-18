//
//  MediaImage.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import Foundation

struct MediaImage: Codable, Hashable {
    let aspectRatio: Double?
    let height: Int?
    let filePath: String?
    let voteAverage: Double?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case width
    }

    var originalImageUrl: URL? {
        guard let filePath else { return nil }
        return URL(
            string: PathBuilder.image(
                type: .original,
                imagePath: filePath
            )
        )
    }
}
