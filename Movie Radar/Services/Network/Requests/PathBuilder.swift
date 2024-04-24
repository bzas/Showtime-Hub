//
//  PathBuilder.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct PathBuilder {
    private static let apiVersion = 3
    private static let baseUrl = "https://api.themoviedb.org"
    private static let apiKeyQueryItem = URLQueryItem(
        name: "api_key",
        value: "9a6438f6c6ac059b769cbf8f5e4a2b9c"
    )

    static func request(_ path: Path, queryItems: [URLQueryItem] = []) -> URLRequest? {
        var urlString = ""

        if path.isImage {
            urlString = baseUrl + path.rawValue
        } else {
            urlString = baseUrl + "/\(apiVersion)" + path.rawValue
        }

        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems + [apiKeyQueryItem]

        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}
