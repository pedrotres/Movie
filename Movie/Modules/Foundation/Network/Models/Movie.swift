//
//  Movie.swift
//  Movie
//
//  Created by pedro tres on 29/11/23.
//

import Foundation

public struct Movie: Equatable, Decodable {
    
    // MARK: - Public properties
    
    public let search: [Search]
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
         case search = "Search"
     }
}

// MARK: - Search

extension Movie {
    
    public struct Search: Equatable, Decodable {
        
        // MARK: - Public properties
        
        public let title: String
        public let year: String
        public let imdbID: String
        public let imageURL: URL
        
        // MARK: - CodingKeys
        
        enum CodingKeys: String, CodingKey {
             case title = "Title"
             case year = "Year"
             case imdbID
             case imageURL = "Poster"
         }
    }
}
