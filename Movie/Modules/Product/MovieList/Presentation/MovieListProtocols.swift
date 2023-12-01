//
//  MovieListProtocols.swift
//  Movie
//
//  Created by pedro tres on 01/12/23.
//

import Foundation
import UIKit

protocol MovieListPresenterProtocol {
    var view: MovieListPresenterDelegate? { get set }
    var interactor: MovieListInteractorProtocol { get set }
    var router: MovieListRouterProtocol { get set }
    
    func didTapSearch(title: String)
}

protocol MovieListRouterProtocol {
    static func createModule() -> UIViewController
}

protocol MovieListInteractorProtocol {
    var presenter: MovieListInteractorDelegate? { get set }
    func fetchData(movie: String)
}
