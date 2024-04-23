//
//  MovieClient.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import Foundation

struct APIService {
    
    func getPopularMovies(page: Int = 1) async throws -> MovieList? {
        guard let request = PathBuilder.request(.popular) else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(
            MovieList.self,
            from: data
        )
    }
    
    func searchMovies(queryString: String, page: Int = 1) async throws -> MovieList? {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "query", value: queryString),
        ]
        
        guard let request = PathBuilder.request(.search, queryItems: queryItems) else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(
            MovieList.self,
            from: data
        )
    }
}
