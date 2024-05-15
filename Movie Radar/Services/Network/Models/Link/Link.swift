//
//  Link.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import Foundation

enum LinkType: CaseIterable {
    case imdb,
         instagram,
         facebook,
         twitter

    var imageName: String {
        switch self {
        case .imdb:
            "imdbLogo"
        case .facebook:
            "facebookLogo"
        case .instagram:
            "instagramLogo"
        case .twitter:
            "twitterLogo"
        }
    }
}

struct MovieLink: Hashable {
    var type: LinkType
    var url: URL

    init?(type: LinkType, url: URL?) {
        guard let url else { return nil }
        self.type = type
        self.url = url
    }
}
