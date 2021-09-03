//
//  BobaFetchFilmsTests.swift
//  BobaFetchTests
//
//  Created by Miguel Cuellar on 02/09/21.
//

import XCTest
@testable import BobaFetch

class BobaFetchFilmsTests: XCTestCase {

    func testDefaultEyes() throws {
        BobbaFetcher.getFilms(sample: true) { filmsRequest in
            switch filmsRequest {
            case .success(let films):
                XCTAssertEqual(films.count, 6)
                XCTAssertEqual(films.first?.title, "A New Hope")
                XCTAssertEqual(films.first?.openingCrawl ,"It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy....")
            case .failure(let error):
                XCTAssertEqual("Error", error.localizedDescription)
            }
        }
    }
    
    func testLastFilm() throws {
        BobbaFetcher.getFilms(sample: true) { filmsRequest in
            switch filmsRequest {
            case .success(let films):
                XCTAssertEqual(films.count, 6)
                XCTAssertEqual(films.last?.title, "Revenge of the Sith")
            case .failure(let error):
                XCTAssertEqual("Error", error.localizedDescription)
            }
        }
    }
}
