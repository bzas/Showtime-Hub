//
//  Endpoints.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension APIService {

    // MARK: - /movie/popular
    func getPopularMovies(page: Int = 1) async throws -> MovieList? {
        guard let request = PathBuilder.request(.popular) else {
            return nil
        }

        return try await perform(request: request)
    }

    // MARK: - /search/movie
    func searchMovies(queryString: String, page: Int = 1) async throws -> MovieList? {
        let queryItems = [
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "query", value: queryString)
        ]

        guard let request = PathBuilder.request(.search, queryItems: queryItems) else {
            return nil
        }

        return try await perform(request: request)
    }
}
