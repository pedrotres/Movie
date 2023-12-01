//
//  MovieListInteractor.swift
//  Movie
//
//  Created by pedro tres on 01/12/23.
//

import Foundation

protocol MovieListInteractorDelegate: AnyObject {
    func didFetchData(movie: Movie)
}

final class ContactListInteractor: MovieListInteractorProtocol {
    weak var presenter: MovieListInteractorDelegate?
    private let service: MovieServiceProtocol

    init(service: MovieServiceProtocol) {
        self.service = service
    }

    func fetchData(movie: String) {
        service.fetchMovies(movie) { [weak self] movie in
            guard 
                let self = self,
                let movie
            else { return }
            
            self.presenter?.didFetchData(movie: movie)
        }
    }
}
