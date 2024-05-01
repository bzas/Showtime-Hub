//
//  MovieDetailViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension MovieDetailView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Published var movie: Movie
        @Published var movieActors: [Cast] = []
        @Published var movieRecommendationsList = MovieList()
        @Published var reviewList = ReviewList()
        @Published var linkList: LinkList?
        @Published var showDetailMovie = false
        @Published var detailMovieToShow: Movie? {
            didSet {
                showDetailMovie.toggle()
            }
        }

        init(apiService: APIService, movie: Movie) {
            self.apiService = apiService
            self.movie = movie
            Task {
                await fetchDetailMovie()
                await fetchMovieActors()
                await fetchSimilarMovies()
                await fetchReviews()
                await fetchLinks()
            }
        }

        func fetchDetailMovie() async {
            if let movieDetail = await apiService.getMovieDetail(id: movie.id) {
                await MainActor.run {
                    movie = movieDetail
                }
            }
        }

        func fetchMovieActors() async {
            if let movieActors = await apiService.getMovieActors(id: movie.id) {
                await MainActor.run {
                    self.movieActors = movieActors
                }
            }
        }

        func fetchSimilarMovies() async {
            if let movieRecommendationsList = await apiService.getMovieRecommendations(id: movie.id) {
                await MainActor.run {
                    self.movieRecommendationsList = movieRecommendationsList
                }
            }
        }

        func fetchReviews() async {
            if let reviewList = await apiService.getMovieReviews(id: movie.id) {
                await MainActor.run {
                    self.reviewList = reviewList
                }
            }
        }

        func fetchLinks() async {
            if let linkList = await apiService.getMovieLinks(id: movie.id) {
                await MainActor.run {
                    self.linkList = linkList
                }
            }
        }
    }
}
