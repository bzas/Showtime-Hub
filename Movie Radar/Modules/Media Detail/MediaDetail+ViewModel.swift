//
//  MediaDetail+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI

extension MediaDetailView {
    class ViewModel: ObservableObject {
        private let zoomCorrection = UIScreen.main.bounds.height / 4
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
                withAnimation(.spring(duration: 0.3)) {
                    showToast = true
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
                withAnimation(.spring(duration: 0.3)) {
                    showDetailImage.toggle()
                }
            }
        }
        
        @Published var showDetailSeason = false
        @Published var seasonIndexToShow: Int? {
            didSet {
                withAnimation(.spring(duration: 0.3)) {
                    showDetailSeason.toggle()
                }
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
                withAnimation(.spring(duration: 0.3)) {
                    showDetailReview.toggle()
                }
            }
        }
        
        @Published var productionCrew: [GenericCrew] = []
        @Published var isHeaderHidden = false
        @Published var showHeaderInfo = false
        @Published var showHeaderGradient = false
        @Published var imageZoom = 0.0
        
        var imageHeaderHeight: CGFloat {
            if UIDevice.isIPad {
                return max(600, UIScreen.main.bounds.height * 0.75)
            }
            return min(600, UIScreen.main.bounds.height * 0.75)
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
                await fetchWatchProviders()
            }
        }

        func fetchDetail() async {
            if let mediaDetail = await apiService.getDetail(type: type, id: media.id) {
                let crew = mediaDetail.creators?.map {
                    GenericCrew(
                        name: $0.name,
                        imageUrl: $0.imageUrl
                    )
                } ?? []
                await MainActor.run {
                    media = mediaDetail
                    productionCrew.append(contentsOf: crew)
                }
            }
        }

        func fetchMediaActors() async {
            if let movieCredits = await apiService.getMediaActors(type: type, id: media.id) {
                let crew = movieCredits.directors.map {
                    GenericCrew(
                        name: $0.name,
                        imageUrl: $0.imageUrl
                    )
                }
                await MainActor.run {
                    mediaActors = movieCredits.actors
                    if type.isMovie {
                        productionCrew = crew
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
        
        func updateZoom(_ value: CGFloat) {
            var zoomToAdd = 0.0
            if value > 0 {
                zoomToAdd = value / zoomCorrection
            }
            
            imageZoom = 1 + zoomToAdd
        }
    }
}
