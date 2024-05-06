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
        @Published var detailLoaded = false
        @Published var birthInfo: String?

        init(apiService: APIService, personId: Int) {
            self.apiService = apiService
            self.personId = personId
            fetchDetail()
        }

        func fetchDetail() {
            Task {
                person = await apiService.getPersonDetail(id: personId)
                if var birth = person?.birthday {
                    if let deathday = person?.deathday {
                        birth = birth.replacingOccurrences(of: "-", with: "/")
                        self.birthInfo = birth.appending(" - " + deathday.replacingOccurrences(of: "-", with: "/"))
                    }
                }
                detailLoaded = true
            }
        }
    }
}
