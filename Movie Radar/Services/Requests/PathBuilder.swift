//
//  PathBuilder.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

enum ImageType: String {
    case wide = "/t/p/w500",
         square = "/t/p/w470_and_h470_face",
         poster = "/t/p/w220_and_h330_face",
         original = "/t/p/original"
}

struct PathBuilder {
    static let baseUrl = "https://api.themoviedb.org"
    private static let imgBaseUrl = "https://www.themoviedb.org"
    private static let apiVersion = 3

    static func image(type: ImageType, imagePath: String) -> String {
        imgBaseUrl + type.rawValue + imagePath
    }

    static func request(
        _ path: Path,
        queryItems: [URLQueryItem],
        pathComponent: String = ""
    ) -> URLRequest? {
        let urlString = String(format: baseUrl + "/\(apiVersion)" + path.rawValue, pathComponent)
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}
