//
//  MovieListRouter.swift
//  Movie
//
//  Created by pedro tres on 01/12/23.
//

import Foundation
import UIKit

typealias MovieListInterable = MovieListPresenterProtocol & MovieListInteractorDelegate

final class MovieListRouter: MovieListRouterProtocol {
    
    static func createModule() -> UIViewController {
        let networkClient = NetworkClient()
        let service = MovieService(networkClient: networkClient)
        let interactor = ContactListInteractor(service: service)
        let router = MovieListRouter()
        let presenter: MovieListInterable = MovieListPresenter(
            interactor: interactor,
            router: router
        )
        
        let viewController = MovieListViewController(presenter: presenter)
        viewController.presenter.view = viewController
        viewController.presenter.interactor.presenter = presenter
        
        return viewController
    }
    
}
