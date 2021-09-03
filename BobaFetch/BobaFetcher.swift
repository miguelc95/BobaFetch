//
//  BobaFetcher.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

public class BobbaFetcher {
    public static func getEyeColors(completion: @escaping (Result<[Eyes], Error>) -> Void){
        Network.getExternalData(fileLocation: .eyeColor, method: .get, parameters: nil, stringParameters: nil) { (people: PeopleRequest?, error) in
            if let eyes = people?.results {
                completion(.success(Array(eyes[0..<5])))
            } else {
                completion(.failure(error!))
            }
        }
    }
}
