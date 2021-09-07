//
//  BobaFetch.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

/*
 BobaFetcher Class that contains the abstract services allowing to call SWAPI API and parsing them to readable responses
 */

public class BobbaFetcher {
    /// This function returns an array of characters which contain  their `name` and their `eye color`.
    ///
    /// ```
    /// {"name":"C-3PO","eye_color":"yellow"}
    /// ```
    ///
    /// - Warning: Returns in a completion handler a Swift Result with the array or a BobaFetchError
    /// - Parameter limit: The amount of characters wanted to be returned.
    /// - Parameter search: A search string to query results.
    /// - Parameter sample: This variable allows us to test with a JSON.

    /// - Returns: completion handler a Swift Result with the array or a BobaFetchError `Swift.Result<[Eyes], BobaFetchError>`.
    public static func getEyeColors(limit: Int = 5,search: String? = nil, sample: Bool = false, completion: @escaping (Swift.Result<[Eyes], BobaFetchError>) -> Void) {
        Network.getExternalData(fileLocation: .eyeColor(search), sample: sample) { (result: Swift.Result<PeopleRequest?,BobaFetchError>) in
            switch result {
            case .success(let people):
                if let eyes = people?.results {
                    let filteredEyes = eyes.count > limit ? Array(eyes[0..<limit]) : eyes
                    completion(.success(filteredEyes))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// This function returns an array of Planets which contain  their `name`,`climate` and `Population`.
    ///
    /// ```
    /// {"name":"Tatooine","climate":"arid", "population":"200000 }
    /// ```
    ///
    /// - Warning: Returns in a completion handler a Swift Result with the array or a BobaFetchError
    /// - Parameter limit: The amount of characters wanted to be returned.
    /// - Parameter search: A search string to query results.
    /// - Parameter sample: This variable allows us to test with a JSON.

    /// - Returns: completion handler a Swift Result with the array or a BobaFetchError `Swift.Result<[Planet], BobaFetchError>`.
    public static func getPlanets(limit: Int = 5,search: String? = nil, sample:Bool = false, completion: @escaping (Swift.Result<[Planet], BobaFetchError>) -> Void) {
        Network.getExternalData(fileLocation: .planets(search)) { (result: Swift.Result<PlanetsRequest?,BobaFetchError>) in
            switch result {
            case .success(let planetsRequest):
                if let planets = planetsRequest?.results {
                    let populationPlanets = planets.filter { $0.population != "unknown" }
                    let filteredPlanets = populationPlanets.count > limit ? Array(populationPlanets[0..<limit]) : populationPlanets
                    completion(.success(filteredPlanets))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    /// This function returns an array of Films which contain their `title`,`opening crawl` and `release date`.
    ///
    /// ```
    /// {"title":"A new hope","open_crawl":"_", "release_date":"1977-05-25 }
    /// ```
    ///
    /// - Warning: Returns in a completion handler a Swift Result with the array or a BobaFetchError
    /// - Parameter search: A search string to query results.
    /// - Parameter sample: This variable allows us to test with a JSON.

    /// - Returns: completion handler a Swift Result with the array or a BobaFetchError `Swift.Result<[Film], BobaFetchError>`.
    public static func getFilms(search: String? = nil, sample: Bool = false, completion: @escaping (Swift.Result<[Film], BobaFetchError>) -> Void) {
        Network.getExternalData(fileLocation: .films(search), sample: sample) { (result: Swift.Result<FilmsRequest?,BobaFetchError>) in
            switch result {
            case .success(let filmsRequest):
                if let films = filmsRequest?.results {
                    completion(.success(films))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
