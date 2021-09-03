//
//  Planets.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

struct PlanetsRequest: Codable {
    let results: [Planet]
}

// MARK: - Result
public struct Planet: Codable {
    public let name: String
    public let climate: String
    public let population: String
}
