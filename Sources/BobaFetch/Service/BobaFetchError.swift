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
    /// BobaFetchError has a descriptive error for the things that may go wrong when using BobaFetch.
    ///
    /// ```
    /// invalidURL,retrievalError, decodingError
    /// ```
    ///
    /// - Warning: Not yet localized, TODO
    
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
