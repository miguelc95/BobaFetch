//
//  Networking.swift
//  BobaFetch
//
//  Created by Miguel Cuellar on 02/09/21.
//

import Foundation

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

enum method : String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case options = "OPTIONS"
}

class Network {
    static func getExternalData<T: Decodable>(fileLocation: Endpoints, method: method, parameters : [String: Any]?, stringParameters: String?, completionHandler: @escaping (T?, Error?) -> Void){

        print("""
            \n
            BobaFetch request made 📲.\n
            Endpoint: \(fileLocation) \n
            Method: \(method.rawValue) \n
            """)
            
        if let url = URL(string: fileLocation.endpoint.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? "") {
            var request = URLRequest(url: url)
            
            request.httpMethod = method.rawValue
            request.httpBody = parameters?.percentEncoded()

            if method == .post {
                
                request.setValue("application/json; charset=utf-8",
                     forHTTPHeaderField: "Content-Type")
                request.setValue("application/json; charset=utf-8",
                     forHTTPHeaderField: "Content-Type")

                if let parameters = parameters {
                    request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
                } else if let stringParameters = stringParameters {
                    request.httpBody = stringParameters.data(using: String.Encoding.utf8)
                }
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
                print("Status code: \(statusCode)")

                if error != nil {
                    completionHandler(nil, error)
                }
                
                if statusCode != 200 {
                    completionHandler(nil, error)
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
                            completionHandler(typedObject, nil)
                        }
                    }
                } catch {
                    completionHandler(nil, error)
                }
            }
            
            task.resume()
        } else {
            completionHandler(nil, NSError(domain: "Url does not exist", code: 1001, userInfo: nil))
        }
        
    }
}

