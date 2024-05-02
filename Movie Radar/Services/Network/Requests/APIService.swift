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

    var defaultQueryItems: [URLQueryItem] {
        [
            apiKeyQueryItem,
            languageQueryItem
        ]
    }

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
            let (data, response) = try await URLSession.shared.data(for: request)
            log(response: response as? HTTPURLResponse)

            return try JSONDecoder().decode(
                T.self,
                from: data
            )
        } catch {
            print(error)
            return nil
        }
    }

    func log(response: HTTPURLResponse?) {
        let logSymbol = response?.statusCode == 200 ? "✅" : "❌"
        print("\n\(logSymbol) Request")
        print("Status Code: \(response?.statusCode ?? -1)")
        print(response?.url?.absoluteString ?? "Invalid URL", terminator: "\n\n")

    }
}
