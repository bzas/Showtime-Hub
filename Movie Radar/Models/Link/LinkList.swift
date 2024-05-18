//
//  LinkList.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 1/5/24.
//

import Foundation

struct LinkList: Codable {
    let id: Int
    let imdbId, facebookId, instagramId, twitterId: String?

    func link(type: LinkType) -> URL? {
        var urlString = ""
        switch type {
        case .imdb:
            guard let imdbId else { return nil }
            urlString = "https://www.imdb.com/title/\(imdbId)"
        case .facebook:
            guard let facebookId else { return nil }
            urlString = "https://www.facebook.com/\(facebookId)"
        case .instagram:
            guard let instagramId else { return nil }
            urlString = "https://instagram.com/\(instagramId)"
        case .twitter:
            guard let twitterId else { return nil }
            urlString = "https://twitter.com/\(twitterId)"
        }

        return URL(string: urlString)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case imdbId = "imdb_id"
        case facebookId = "facebook_id"
        case instagramId = "instagram_id"
        case twitterId = "twitter_id"
    }
}
