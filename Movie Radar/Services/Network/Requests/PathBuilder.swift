//
//  PathBuilder.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

enum Path: String {
    case popular = "/movie/popular",
         search = "/search/movie",
         genres = "/genre/movie/list",
         discover = "/discover/movie",
         detail = "/movie/"
}

struct PathBuilder {
    static let baseUrl = "https://api.themoviedb.org"
    private static let imgBaseUrl = "https://www.themoviedb.org"
    private static let apiVersion = 3

    static func image(imagePath: String) -> String {
        imgBaseUrl + "/t/p/w220_and_h330_face" + imagePath
    }

    static func wideImage(imagePath: String) -> String {
        imgBaseUrl + "/t/p/w500" + imagePath
    }

    static func request(_ path: Path, queryItems: [URLQueryItem], pathComponent: String = "") -> URLRequest? {
        let urlString = baseUrl + "/\(apiVersion)" + path.rawValue + pathComponent
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryItems
        guard let url = urlComponents?.url else { return nil }
        return URLRequest(url: url)
    }
}
