//
//  Endpoints.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

public enum Endpoints {
    
    case eyeColor(String?)
    case planets(String?)
    
    var path: String {
        switch self {
        case .eyeColor:
            return "people"
        case .planets:
            return "planets"
        }
    }
    
    var endpoint: String {
        let base = "https://swapi.dev/api/\(path)/?format=json"
        switch self {
        case .eyeColor(let searchText):
            guard let searchQuery = searchText else {
                return base
            }
            return "\(base)&search=\(searchQuery)"
        case .planets(let searchText):
            guard let searchQuery = searchText else {
                return base
            }
            return "\(base)&search=\(searchQuery)"
        }
    }
    
}
