//
//  MovieClient.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

class APIService {
    var apiKeyQueryItem: URLQueryItem
    var languageQueryItem = URLQueryItem(
        name: "language",
        value: Locale.current.language.region?.identifier.localizedLowercase
    )

    init(apiKey: String? = nil) {
        apiKeyQueryItem = URLQueryItem(
            name: "api_key",
            value: apiKey
        )
    }

    func updateApiKey(_ apiKey: String) {
        apiKeyQueryItem = URLQueryItem(
            name: "api_key",
            value: apiKey
        )
    }

    func perform<T: Decodable>(request: URLRequest) async -> T? {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return try JSONDecoder().decode(
                T.self,
                from: data
            )
        } catch {
            print(error)
            return nil
        }
    }
}
