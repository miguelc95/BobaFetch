//
//  BobaFetcher.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

public class BobbaFetcher {
    public static func getEyeColors(limit: Int = 5,search: String? = nil, completion: @escaping (Result<[Eyes], Error>) -> Void) {
        Network.getExternalData(fileLocation: .eyeColor(search), method: .get, parameters: nil, stringParameters: nil) { (people: PeopleRequest?, error) in
            if let eyes = people?.results {
                let filteredEyes = eyes.count > limit ? Array(eyes[0..<limit]) : eyes
                completion(.success(filteredEyes))
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    public static func getPlanets(limit: Int = 5,search: String? = nil, completion: @escaping (Result<[Planet], Error>) -> Void) {
        Network.getExternalData(fileLocation: .planets(search), method: .get, parameters: nil, stringParameters: nil) { (planetsRequest: PlanetsRequest?, error) in
            if let planets = planetsRequest?.results {
                let filteredPlanets = planets.count > limit ? Array(planets[0..<limit]) : planets
                completion(.success(filteredPlanets))
            } else {
                completion(.failure(error!))
            }
        }
    }
}
