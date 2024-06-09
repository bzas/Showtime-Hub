//
//  MovieClient.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

class APIService {
    static let apiKeyPath = "api_key"
    
    var apiKeyQueryItem: URLQueryItem!
    var languageQueryItem = URLQueryItem(
        name: "language",
        value: Locale.current.region?.identifier.localizedLowercase
    )

    var defaultQueryItems: [URLQueryItem] {
        [
            apiKeyQueryItem,
            languageQueryItem
        ]
    }
    
    var currentApiKey: String? {
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }
        
        let plistData = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)
        let dict = plistData as? [String: Any]
        return dict?[Self.apiKeyPath] as? String
    }
    
    init() {
        guard let currentApiKey else {
            fatalError("No API key provided")
        }
        
        apiKeyQueryItem = URLQueryItem(
            name: Self.apiKeyPath,
            value: currentApiKey
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
    
    func defaultQueryItems(appendingToResponse: [String]) -> [URLQueryItem] {
        guard !appendingToResponse.isEmpty else { return defaultQueryItems }
        
        let appendVideosQueryItem = URLQueryItem(
            name: "append_to_response",
            value: appendingToResponse.joined(separator: ",")
        )
        
        return defaultQueryItems + [appendVideosQueryItem]
    }

    func log(response: HTTPURLResponse?) {
        let logSymbol = response?.statusCode == 200 ? "✅" : "❌"
        print("\n\(logSymbol) Request")
        print("Status Code: \(response?.statusCode ?? -1)")
        print(response?.url?.absoluteString ?? "Invalid URL", terminator: "\n\n")
    }
}
