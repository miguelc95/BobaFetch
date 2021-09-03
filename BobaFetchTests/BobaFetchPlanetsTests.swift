//
//  BobaFetchPlanetsTests.swift
//  BobaFetchTests
//
//  Created by Miguel Cuellar on 02/09/21.
//

import XCTest
@testable import BobaFetch

class BobaFetchPlanetsTests: XCTestCase {

    func testDefaultPlanets() throws {
        BobbaFetcher.getPlanets(sample: true) { planetsRequest in
            switch planetsRequest {
            case .success(let planets):
                XCTAssertEqual(planets.count, 5)
                XCTAssertEqual(planets.first?.name, "Tatooine")
                XCTAssertEqual(planets.first?.population, "200000")

            case .failure(let error):
                XCTAssertEqual("Error", error.localizedDescription)
            }
        }
    }
    
    func testAmountPlanets() throws {
        BobbaFetcher.getPlanets(limit: 10, sample: true) { planetsRequest in
            switch planetsRequest {
            case .success(let planets):
                XCTAssertEqual(planets.count, 10)
                XCTAssertEqual(planets.last?.name, "Kamino")
                XCTAssertEqual(planets.last?.population, "1000000000")
                XCTAssertEqual(planets.last?.climate, "temperate")
            case .failure(let error):
                XCTAssertEqual("Error", error.localizedDescription)
            }
        }
    }
}
