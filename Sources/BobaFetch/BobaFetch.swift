import Foundation

public class BobbaFetcher {
    
    var printResults: Bool = true
    
    public static func getEyeColors(limit: Int = 5,search: String? = nil, sample: Bool = false, completion: @escaping (Swift.Result<[Eyes], Error>) -> Void) {
        Network.getExternalData(fileLocation: .eyeColor(search), sample: sample) { (people: PeopleRequest?, error) in
            if let eyes = people?.results {
                let filteredEyes = eyes.count > limit && eyes.count < limit ? Array(eyes[0..<limit]) : eyes
                completion(.success(filteredEyes))
            } else {
                completion(.failure(error ?? NSError(domain: "Error retrieving eyes", code: 404)))
            }
        }
    }
    
    public static func getPlanets(limit: Int = 5,search: String? = nil, sample:Bool = false, completion: @escaping (Swift.Result<[Planet], Error>) -> Void) {
        Network.getExternalData(fileLocation: .planets(search)) { (planetsRequest: PlanetsRequest?, error) in
            if let planets = planetsRequest?.results {
                let filteredPlanets = planets.count > limit ? Array(planets[0..<limit]) : planets
                completion(.success(filteredPlanets))
            } else {
                completion(.failure(error ?? NSError(domain: "Error retrieving planets", code: 404)))
            }
        }
    }
    
    public static func getFilms(search: String? = nil, sample: Bool = false, completion: @escaping (Swift.Result<[Film], Error>) -> Void) {
        Network.getExternalData(fileLocation: .films(search), sample: sample) { (filmsRequest: FilmsRequest?, error) in
            if let films = filmsRequest?.results {
                completion(.success(films))
            } else {
                completion(.failure(error ?? NSError(domain: "Error retrieving films", code: 404)))
            }
        }
    }
}
