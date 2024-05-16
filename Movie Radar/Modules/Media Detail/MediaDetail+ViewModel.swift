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
        var type: MediaType
        
        @Published var media: Media
        @Published var imageList = ImageList()
        @Published var mediaActors: [Cast] = []
        @Published var director: Cast?
        @Published var recommendationsList = MediaList()
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

        @Published var showDetailMedia = false
        @Published var detailMediaToShow: Media? {
            didSet {
                showDetailMedia.toggle()
            }
        }

        @Published var showDetailReview = false
        @Published var detailReviewToShow: Review? {
            didSet {
                showDetailReview.toggle()
            }
        }

        init(
            apiService: APIService,
            media: Media,
            type: MediaType
        ) {
            self.apiService = apiService
            self.media = media
            self.type = type
            Task {
                await fetchDetail()
                await fetchImages()
                await fetchMediaActors()
                await fetchSimilar()
                await fetchReviews()
                await fetchLinks()
            }
        }

        func fetchDetail() async {
            if let movieDetail = await apiService.getDetail(type: type, id: media.id) {
                await MainActor.run {
                    media = movieDetail
                }
            }
        }

        func fetchMediaActors() async {
            if let movieCredits = await apiService.getMediaActors(type: type, id: media.id) {
                await MainActor.run {
                    mediaActors = movieCredits.actors
                    director = movieCredits.director
                }
            }
        }

        func fetchSimilar() async {
            if let movieRecommendationsList = await apiService.getRecommendations(
                type: type,
                id: media.id
            ) {
                await MainActor.run {
                    self.recommendationsList = movieRecommendationsList
                }
            }
        }

        func fetchReviews() async {
            if let reviewList = await apiService.getReviews(type: type, id: media.id) {
                await MainActor.run {
                    self.reviewList = reviewList
                }
            }
        }

        func fetchLinks() async {
            if let linkList = await apiService.getLinks(type: type, id: media.id) {
                await MainActor.run {
                    self.linkList = linkList
                }
            }
        }

        func fetchImages() async {
            if let imageList = await apiService.getImages(type: type, id: media.id) {
                await MainActor.run {
                    self.imageList = imageList
                }
            }
        }
    }
}