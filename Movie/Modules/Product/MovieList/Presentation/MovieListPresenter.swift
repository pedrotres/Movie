//
//  MovieListPresenter.swift
//  Movie
//
//  Created by pedro tres on 01/12/23.
//

import Foundation

protocol MovieListPresenterDelegate: AnyObject {
    func showData(_ movie: Movie)
}

final class MovieListPresenter: MovieListPresenterProtocol {
    weak var view: MovieListPresenterDelegate?
    
    var interactor: MovieListInteractorProtocol
    
    var router: MovieListRouterProtocol
    
    init(interactor: MovieListInteractorProtocol, router: MovieListRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func didTapSearch(title: String) {
        interactor.fetchData(movie: title)
    }
}

extension MovieListPresenter: MovieListInteractorDelegate {
    
    func didFetchData(movie: Movie) {
        view?.showData(movie)
    }
}
