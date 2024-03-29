//
//  Eyes.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

struct PeopleRequest: Codable {
    let results: [Eyes]
}

public struct Eyes: Codable {
    public let eyeColor: String
    public let name: String
    
    
    enum CodingKeys: String, CodingKey {
        case eyeColor = "eye_color"
        case name
        
    }
}
