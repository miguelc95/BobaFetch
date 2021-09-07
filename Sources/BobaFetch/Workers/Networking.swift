//
//  Networking.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

class Network {
    static func getExternalData<T: Decodable>(fileLocation: Endpoints, sample: Bool = false, completionHandler: @escaping (Swift.Result<T?, BobaFetchError>) -> Void){
        
        print("""
            \n
            BobaFetch request made 📲.\n
            Endpoint: \(fileLocation) \n
            Method: GET \n
            Sample: \(sample)
            """)
        
        guard !sample else {
            
            let bundle =  Bundle(identifier: "BobaFetch")!
            let decodedData = bundle.decode(T?.self, from: fileLocation.sample)
            completionHandler(.success(decodedData))
            return
        }
        
        guard let url = URL(string: fileLocation.endpoint.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") else {
            return
                completionHandler(.failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
            print("Status code: \(statusCode)")
            
            if error != nil, statusCode != 200 {
                completionHandler(.failure(.retrievalError))
            }
            
            do {
                if let jsonData = data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
                        let value = try decoder.singleValueContainer().decode(String.self)
                        
                        let formatter = DateFormatter()
                        
                        formatter.calendar = Calendar(identifier: .iso8601)
                        formatter.locale = Locale(identifier: "en_US_POSIX")
                        formatter.timeZone = TimeZone.current
                        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
                        
                        if let date = formatter.date(from: value) {
                            return date
                        }
                        return Date()
                    }
                    let typedObject: T? = try decoder.decode(T.self, from: jsonData)
                    DispatchQueue.main.async {
                        completionHandler(.success(typedObject))
                    }
                }
            } catch {
                completionHandler(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
}

