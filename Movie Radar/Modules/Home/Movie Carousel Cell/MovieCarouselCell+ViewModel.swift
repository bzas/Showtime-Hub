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
        var movie: Movie

        init(movie: Movie) {
            self.movie = movie
        }
    }
}
