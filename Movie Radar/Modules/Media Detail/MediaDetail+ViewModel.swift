//
//  MediaDetail+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import Foundation

extension MediaDetailView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        @Published var movie: Media
        @Published var imageList = ImageList()
        @Published var movieActors: [Cast] = []
        @Published var director: Cast?
        @Published var movieRecommendationsList = MediaList()
        @Published var reviewList = ReviewList()
        @Published var linkList: LinkList?

        @Published var showDetailImage = false
        @Published var imageIndexToShow: Int? {
            didSet {
                showDetailImage.toggle()
            }
        }

        @Published var showDetailPerson = false
        @Published var detailPersonToShow: Cast? {
            didSet {
                showDetailPerson.toggle()
            }
        }

        @Published var showDetailMovie = false
        @Published var detailMovieToShow: Media? {
            didSet {
                showDetailMovie.toggle()
            }
        }

        @Published var showDetailReview = false
        @Published var detailReviewToShow: Review? {
            didSet {
                showDetailReview.toggle()
            }
        }

        init(apiService: APIService, movie: Media) {
            self.apiService = apiService
            self.movie = movie
            Task {
                await fetchDetailMovie()
                await fetchImages()
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
            if let movieCredits = await apiService.getMovieActors(id: movie.id) {
                await MainActor.run {
                    movieActors = movieCredits.actors
                    director = movieCredits.director
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

        func fetchImages() async {
            if let imageList = await apiService.getMovieImages(id: movie.id) {
                await MainActor.run {
                    self.imageList = imageList
                }
            }
        }
    }
}
