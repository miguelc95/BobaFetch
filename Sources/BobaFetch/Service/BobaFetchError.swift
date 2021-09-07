//
//  BobaFetchError.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 07/09/21.
//

import Foundation

public enum BobaFetchError: LocalizedError {
    case invalidURL

    case retrievalError
    
    case decodingError
}

extension BobaFetchError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidURL:
            return "The url is not valid"
        case .retrievalError:
            return "Unable to retrieve data"
        case .decodingError:
            return "Error decoding data"
        }
    }
}
