//
//  BobaFetchTests.swift
//  BobaFetchTests
//
//  Created by Miguel Cuellar on 02/09/21.
//

import XCTest
@testable import BobaFetch

class BobaFetchEyesTests: XCTestCase {

    func testDefaultEyes() throws {
        BobbaFetcher.getEyeColors(sample: true) { eyesRequest in
            switch eyesRequest {
            case .success(let eyes):
                XCTAssertEqual(eyes.count, 10)
                XCTAssertEqual(eyes.first?.eyeColor, "blue")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (Error retrieving eyes error 404.)")
            }
        }
    }
    
    func testAmountEyes() throws {
        BobbaFetcher.getEyeColors(limit: 10, sample: true) { eyesRequest in
            switch eyesRequest {
            case .success(let eyes):
                XCTAssertEqual(eyes.count, 10)
                XCTAssertEqual(eyes.last?.eyeColor, "blue-gray")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (Error retrieving eyes error 404.)")
            }
        }
    }
}
