//
//  MovieListViewConfiguration.swift
//  Movie
//
//  Created by pedro tres on 30/11/23.
//

import Foundation

enum MovieListViewConfiguration {
    case loading
    case empty
    case list(_: [Movie.Search])
}
