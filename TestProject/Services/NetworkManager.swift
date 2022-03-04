//
//  NetworkManager.swift
//  TestProject
//
//  Created by Виктория Щербакова on 25.02.2022.
//

import Foundation

enum ObtainResult {
    case success(matches: [Match])
    case failure(error: NetworkError)
}

enum NetworkError: Error {
    case unknown
    case decodeFailed(Error)
    case noData
}

final class NetworkManager {
    
    private func getMatchesUrl(date: Date) -> String {
        return "http://api.football-data.org/v2/matches?dateTo=\(getDate(date: date))&dateFrom=\(getDate(date: date))"
    }
    
    private func getDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    func getMatches(date: Date, completion: @escaping (ObtainResult) -> Void) {

        let url = URL(string: getMatchesUrl(date: date))
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("286c47b6f25b40adbfcddd76a9dc3d81", forHTTPHeaderField: "X-Auth-Token")
            
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            var result: ObtainResult
                    
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }

            if error == nil, let jsonData = data {
                
                do {
                    let getMatch = try JSONDecoder().decode(Matches.self, from: jsonData)
                    result = .success(matches: getMatch.matches ?? [])

                } catch {
                    print("Couldn't decode data into")
                    result = .failure(error: NetworkError.decodeFailed(error))
                    return
                }


            } else {
                result = .failure(error: NetworkError.noData)
            }
        
        }.resume()
    }
    
}


