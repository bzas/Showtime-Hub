//
//  Endpoints.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

enum Path: String {
    case search = "/search/movie",
         searchTv = "/search/tv",
         genres = "/genre/movie/list",
         genresTv = "/genre/tv/list",
         discover = "/discover/movie",
         discoverTv = "/discover/tv",
         detail = "/movie/%@",
         detailTv = "/tv/%@",
         upcoming = "/movie/upcoming",
         credits = "/movie/%@/credits",
         creditsTv = "/tv/%@/credits",
         recommendations = "/movie/%@/recommendations",
         recommendationsTv = "/tv/%@/recommendations",
         reviews = "/movie/%@/reviews",
         reviewsTv = "/tv/%@/reviews",
         links = "/movie/%@/external_ids",
         linksTv = "/tv/%@/external_ids",
         images = "/movie/%@/images",
         imagesTv = "/tv/%@/images",
         personDetail = "/person/%@",
         personMovies = "/person/%@/movie_credits",
         personTv = "/person/%@/tv_credits",
         watchProviders = "/movie/%@/watch/providers",
         watchProvidersTv = "/tv/%@/watch/providers"
}

extension APIService {

    // MARK: - /movie/upcoming
    func getUpcomingMovies(page: Int) async -> MediaList? {
        guard let request = PathBuilder.request(.upcoming, queryItems: defaultQueryItems) else {
            return nil
        }

        return await perform(request: request)
    }
    
    func searchAllMedia(queryString: String) async -> [SearchResult] {
        var moviesList = await searchMedia(
            type: .movie,
            queryString: queryString
        ) ?? MediaList()
        let seriesList = await searchMedia(
            type: .tv,
            queryString: queryString
        ) ?? MediaList()
        
        let moviesResults: [SearchResult] = moviesList.results.map {
            .init(media: $0, type: .movie)
        }
        
        let seriesResults: [SearchResult] = seriesList.results.map {
            .init(media: $0, type: .tv)
        }
        
        return (moviesResults + seriesResults).sorted {
            ($0.media.popularity ?? 0) > ($1.media.popularity ?? 0)
        }
    }

    // MARK: - /search/{type}
    func searchMedia(type: MediaType, queryString: String) async -> MediaList? {
        let queryItems = [
            URLQueryItem(name: "page", value: "\(1)"),
            URLQueryItem(name: "query", value: queryString)
        ] + defaultQueryItems

        guard let request = PathBuilder.request(
            type.isMovie ? .search : .searchTv,
            queryItems: queryItems
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /genre/{type}/list
    func getGenres(type: MediaType) async -> GenreList? {
        guard let request = PathBuilder.request(
            type.isMovie ? .genres : .genresTv,
            queryItems: defaultQueryItems
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /discover/{type}
    func discoverMedia(
        type: MediaType,
        genreId: Int?,
        sortType: String,
        page: Int
    ) async -> MediaList? {
        var queryItems = [
            URLQueryItem(name: "include_video", value: "true"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort_by", value: sortType)
        ] + defaultQueryItems

        if let genreId {
            queryItems.append(URLQueryItem(name: "with_genres", value: "\(genreId)"))
        }

        guard let request = PathBuilder.request(
            type.isMovie ? .discover : .discoverTv,
            queryItems: queryItems
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /{type}/{media_id}
    func getDetail(type: MediaType, id: Int) async -> Media? {        
        guard let request = PathBuilder.request(
            type.isMovie ? .detail : .detailTv,
            queryItems: defaultQueryItems(appendingToResponse: ["videos"]),
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /{type}/{media_id}/credits
    func getMediaActors(type: MediaType, id: Int) async -> Credits? {
        guard let request = PathBuilder.request(
            type.isMovie ? .credits : .creditsTv,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /{type}/{media_id}/recommendations
    func getRecommendations(type: MediaType, id: Int) async -> MediaList? {
        guard let request = PathBuilder.request(
            type.isMovie ? .recommendations : .recommendationsTv,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /{type}/{media_id}/reviews
    func getReviews(type: MediaType, id: Int) async -> ReviewList? {
        guard let request = PathBuilder.request(
            type.isMovie ? .reviews : .reviewsTv,
            queryItems: [apiKeyQueryItem],
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /{type}/{media_id}/external_ids
    func getLinks(type: MediaType, id: Int) async -> LinkList? {
        guard let request = PathBuilder.request(
            type.isMovie ? .links : .linksTv,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /{type}/{media_id}/images
    func getImages(type: MediaType, id: Int) async -> ImageList? {
        guard let request = PathBuilder.request(
            type.isMovie ? .images : .imagesTv,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /person/{credit_id}
    func getPersonDetail(id: Int) async -> Person? {
        guard let request = PathBuilder.request(
            .personDetail,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }

    // MARK: - /person/{credit_id}/{type}
    func getPersonMedia(type: MediaType, id: Int) async -> PersonMediaList? {
        guard let request = PathBuilder.request(
            type.isMovie ? .personMovies : .personTv,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }
    
    // MARK: - /{type}/{media_id}/watch/providers
    func getWatchProviders(type: MediaType, id: Int) async -> WatchProviderList? {
        guard let request = PathBuilder.request(
            type.isMovie ? .watchProviders : .watchProvidersTv,
            queryItems: defaultQueryItems,
            pathComponent: "\(id)"
        ) else {
            return nil
        }

        return await perform(request: request)
    }
}
