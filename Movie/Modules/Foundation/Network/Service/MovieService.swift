//
//  Service.swift
//  Movie
//
//  Created by pedro tres on 29/11/23.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchMovies (_ name: String, _ completion: @escaping (Movie?) -> Void)
}

final class MovieService: MovieServiceProtocol {
    
    // MARK: - Injection properties
    
    let networkClient: NetworkClientProtocol
    
    // MARK: - Initialization
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchMovies(_ name: String, _ completion: @escaping (Movie?) -> Void) {
        guard let url = URL(string:"https://www.omdbapi.com/?s=\(name)&apikey=15ef78e5") else { return }
        
        networkClient.performRequest(with: url) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movies = try decoder.decode(Movie.self, from: data)
                completion(movies)
            } catch {
                completion(nil)
            }
        }
    }
}
