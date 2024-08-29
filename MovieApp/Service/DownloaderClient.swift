//
//  DownloaderClient.swift
//  MovieApp
//
//  Created by Şevval Mertoğlu on 28.08.2024.
//

import Foundation

class DownloaderClient {
    
    func downloadFilms(search: String, completion: @escaping
                       (Result<[Film]?, DownloaderError>) -> Void) {
        
        guard let url = URL(string: "https://www.omdbapi.com/?s=\(search)&apikey=ad245365") else {
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noDataReceived))
            }
            
            guard let movieResponse = try? JSONDecoder().decode(Films.self, from: data) else {
                return completion(.failure(.dataProcessingFailed))
            }
            
            completion(.success(movieResponse.films))
            
        }.resume()
    }
    
}

enum DownloaderError: Error {
    case wrongUrl
    case noDataReceived
    case dataProcessingFailed
    
}
