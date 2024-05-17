//
//  PersonDetailView+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import Foundation

extension PersonDetailView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        var personId: Int
        @Published var person: Person?
        @Published var movies = [PersonMedia]()
        @Published var series = [PersonMedia]()
        @Published var detailLoaded = false
        @Published var birthInfo: String?

        @Published var showDetailMedia = false
        @Published var selectedMediaToShow: Media? {
            didSet {
                showDetailMedia.toggle()
            }
        }

        init(apiService: APIService, personId: Int) {
            self.apiService = apiService
            self.personId = personId

            Task {
                await fetchDetail()
                await fetchMovies()
                await fetchSeries()
            }
        }

        func fetchDetail() async {
            guard let person = await apiService.getPersonDetail(id: personId) else { return }

            await MainActor.run {
                self.person = person
                if var birth = person.birthday {
                    birth = birth.replacingOccurrences(of: "-", with: "/")
                    if let deathday = person.deathday {
                        self.birthInfo = birth.appending(" - " + deathday.replacingOccurrences(of: "-", with: "/"))
                    } else {
                        self.birthInfo = birth
                    }
                }
                detailLoaded = true
            }
        }

        func fetchMovies() async {
            if let movieList = await apiService.getPersonMedia(type: .movie, id: personId) {
                await MainActor.run {
                    self.movies = movieList.popular
                }
            }
        }
        
        func fetchSeries() async {
            if let seriesList = await apiService.getPersonMedia(type: .tv, id: personId) {
                await MainActor.run {
                    self.series = seriesList.popular
                }
            }
        }
    }
}
