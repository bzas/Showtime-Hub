//
//  Endpoints.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension APIService {

    // MARK: - /movie/top_rated
    func getTopRatedMovies(page: Int = 1) async -> MovieList? {
        let queryItems = [
            languageQueryItem,
            apiKeyQueryItem
        ]

        guard let request = PathBuilder.request(.topRated, queryItems: queryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/popular
    func getPopularMovies(page: Int = 1) async -> MovieList? {
        let queryItems = [
            languageQueryItem,
            apiKeyQueryItem
        ]

        guard let request = PathBuilder.request(.popular, queryItems: queryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /search/movie
    func searchMovies(queryString: String, page: Int = 1) async -> MovieList? {
        let queryItems = [
            languageQueryItem,
            apiKeyQueryItem,
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "query", value: queryString)
        ]

        guard let request = PathBuilder.request(.search, queryItems: queryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /genre/movie/list
    func getGenres() async -> GenreList? {
        let queryItems = [
            languageQueryItem,
            apiKeyQueryItem
        ]

        guard let request = PathBuilder.request(.genres, queryItems: queryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /discover/movie
    func discoverMovies(genreId: Int?, page: Int = 1) async -> MovieList? {
        var queryItems = [
            URLQueryItem(name: "include_video", value: "true"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            languageQueryItem,
            apiKeyQueryItem
        ]

        if let genreId {
            queryItems.append(URLQueryItem(name: "with_genres", value: "\(genreId)"))
        }

        guard let request = PathBuilder.request(.discover, queryItems: queryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    func getMovieDetail(id: Int) async -> Movie? {
        let queryItems = [
            languageQueryItem,
            apiKeyQueryItem
        ]

        guard let request = PathBuilder.request(
            .detail,
            queryItems: queryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }
}
