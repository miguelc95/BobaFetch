//
//  Films.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

struct FilmsRequest: Codable {
    let results: [Film]
}

// MARK: - Film
public struct Film: Codable {
    public let title: String
    public let openingCrawl, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case title
        case openingCrawl = "opening_crawl"
        case releaseDate = "release_date"
    }
}
