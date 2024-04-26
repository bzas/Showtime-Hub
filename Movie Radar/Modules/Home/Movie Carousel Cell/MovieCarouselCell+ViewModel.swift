//
//  MovieCarouselCell+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 26/4/24.
//

import Foundation

extension MovieCarouselCellView {
    @Observable
    class ViewModel {
        var id: Int?
        var title = ""
        var imageUrl: URL?

        init(movie: Movie) {
            id = movie.id

            if let title = movie.title {
                self.title = title
            }

            if let backdropPath = movie.backdropPath {
                imageUrl = URL(string: PathBuilder.image(imagePath: backdropPath))
            }
        }
    }
}
