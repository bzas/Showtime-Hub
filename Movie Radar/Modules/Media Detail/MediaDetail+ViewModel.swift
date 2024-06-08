//
//  MediaDetail+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

extension MediaDetailView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        var type: MediaType
        
        @Published var media: Media
        @Published var imageList = ImageList()
        @Published var mediaActors: [Cast] = []
        @Published var recommendationsList = MediaList()
        @Published var reviewList = ReviewList()
        @Published var linkList: LinkList?
        
        @Published var showToast = false
        @Published var toastInfo: ToastInfo? {
            didSet {
                withAnimation(.spring) {
                    showToast.toggle()
                }
            }
        }
        
        private var watchInfo: WatchInfo? {
            didSet {
                selectedWatchProviders = watchInfo?.providerList(type: selectedProviderType) ?? []
            }
        }
        @Published var selectedWatchProviders: [ProviderInfo] = []
        @Published var selectedProviderType: ProviderType = .streaming {
            didSet {
                selectedWatchProviders = watchInfo?.providerList(type: selectedProviderType) ?? []
            }
        }

        @Published var showDetailImage = false
        @Published var imageIndexToShow: Int? {
            didSet {
                showDetailImage.toggle()
            }
        }
        
        @Published var showDetailSeason = false
        @Published var seasonIndexToShow: Int? {
            didSet {
                showDetailSeason.toggle()
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
        @Published var reviewIndexToShow: Int? {
            didSet {
                showDetailReview.toggle()
            }
        }
        
        @Published var productionCrew: [GenericCrew] = []

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
                await fetchWatchProviders()
            }
        }

        func fetchDetail() async {
            if let mediaDetail = await apiService.getDetail(type: type, id: media.id) {
                await MainActor.run {
                    media = mediaDetail
                    mediaDetail.creators?.forEach { creator in
                        productionCrew.append(
                            GenericCrew(
                                name: creator.name,
                                imageUrl: creator.imageUrl
                            )
                        )
                    }
                }
            }
        }

        func fetchMediaActors() async {
            if let movieCredits = await apiService.getMediaActors(type: type, id: media.id) {
                await MainActor.run {
                    mediaActors = movieCredits.actors
                    if type.isMovie {
                        productionCrew = movieCredits.directors.map {
                            GenericCrew(
                                name: $0.name,
                                imageUrl: $0.imageUrl
                            )
                        }
                    }
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
        
        func fetchWatchProviders() async {
            if let watchProviderList = await apiService.getWatchProviders(type: type, id: media.id) {
                await MainActor.run {
                    self.watchInfo = watchProviderList.countryResults
                }
            }
        }
    }
}
