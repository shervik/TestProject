//
//  NetworkManager.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

import Foundation

enum ObtainResult {
    case success(matches: [Datum])
    case failure(error: Error?)
}

class NetworkManager {
    
    let session = URLSession.shared
    let decoder = JSONDecoder()

    func getRequest(completion: @escaping (ObtainResult) -> Void) {

        let url = URL(string: "https://datausa.io/api/data?drilldowns=Nation&measures=Population")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
            
        session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
            var result: ObtainResult
                    
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            guard let strongSelf = self else {
                result = .failure(error: error)
                return
            }

            if error == nil, let jsonData = data {

                guard let getMatch = try? strongSelf.decoder.decode(Matches.self, from: jsonData)
                else {
                    print("Couldn't decode data into")
                    result = .failure(error: error)
                    return
                }

                result = .success(matches: getMatch.data!)

            } else {
                result = .failure(error: error)
            }
        
        }.resume()
        
    }
}


