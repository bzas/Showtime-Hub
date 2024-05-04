//
//  Endpoints.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension APIService {

    // MARK: - /movie/top_rated
    func getTopRatedMovies(page: Int) async -> MovieList? {
        guard let request = PathBuilder.request(.topRated, queryItems: defaultQueryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/popular
    func getPopularMovies(page: Int) async -> MovieList? {
        guard let request = PathBuilder.request(.popular, queryItems: defaultQueryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/upcoming
    func getUpcomingMovies(page: Int) async -> MovieList? {
        guard let request = PathBuilder.request(.upcoming, queryItems: defaultQueryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /search/movie
    func searchMovies(queryString: String) async -> MovieList? {
        let queryItems = [
            URLQueryItem(name: "page", value: "\(1)"),
            URLQueryItem(name: "query", value: queryString)
        ] + defaultQueryItems

        guard let request = PathBuilder.request(.search, queryItems: queryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /genre/movie/list
    func getGenres() async -> GenreList? {
        guard let request = PathBuilder.request(.genres, queryItems: defaultQueryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /discover/movie
    func discoverMovies(genreId: Int?, page: Int) async -> MovieList? {
        var queryItems = [
            URLQueryItem(name: "include_video", value: "true"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort_by", value: "popularity.desc")
        ] + defaultQueryItems

        if let genreId {
            queryItems.append(URLQueryItem(name: "with_genres", value: "\(genreId)"))
        }

        guard let request = PathBuilder.request(.discover, queryItems: queryItems) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/{movie_id}
    func getMovieDetail(id: Int) async -> Movie? {
        guard let request = PathBuilder.request(
            .detail,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/{movie_id}/credits
    func getMovieActors(id: Int) async -> [Cast]? {
        guard let request = PathBuilder.request(
            .credits,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        let credits: Credits? = await perform(request: request)
        return credits?.actors ?? []
    }

    // MARK: - /movie/{movie_id}/recommendations
    func getMovieRecommendations(id: Int) async -> MovieList? {
        guard let request = PathBuilder.request(
            .recommendations,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/{movie_id}/reviews
    func getMovieReviews(id: Int) async -> ReviewList? {
        guard let request = PathBuilder.request(
            .reviews,
            queryItems: [apiKeyQueryItem],
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/{movie_id}/external_ids
    func getMovieLinks(id: Int) async -> LinkList? {
        guard let request = PathBuilder.request(
            .links,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /movie/{movie_id}/images
    func getMovieImages(id: Int) async -> ImageList? {
        guard let request = PathBuilder.request(
            .images,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }
}
