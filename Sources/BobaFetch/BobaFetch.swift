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
    
    public static func getEyeColors(limit: Int = 5,search: String? = nil, sample: Bool = false, completion: @escaping (Swift.Result<[Eyes], BobaFetchError>) -> Void) {
        Network.getExternalData(fileLocation: .eyeColor(search), sample: sample) { (result: Swift.Result<PeopleRequest?,BobaFetchError>) in
            switch result {
            case .success(let people):
                if let eyes = people?.results {
                    let filteredEyes = eyes.count > limit && eyes.count < limit ? Array(eyes[0..<limit]) : eyes
                    completion(.success(filteredEyes))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
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
