//
//  MovieListViewController.swift
//  Movie
//
//  Created by pedro tres on 30/11/23.
//

import Foundation
import UIKit

final class MovieListViewController: UIViewController {
    
    private lazy var listView: MovieListView = {
        let listView = MovieListView()
        listView.delegate = self
        return listView
    }()
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    private let service = MovieService(networkClient: NetworkClient())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMovies(title: "Batman")
        self.configureNavigationBar()
    }
    
    private func fetchMovies(title: String){
        self.service.fetchMovies(title){ repositories in
            guard let repositories = repositories else {
                return
            }
            
            let configuration = MovieListViewConfiguration.list(repositories.search)
            
            DispatchQueue.main.async {
                self.listView.updateView(with: configuration)
            }
        }
    }
      
    func navigateToDetails() {
        //Next PR's
    }
}

extension MovieListViewController: MovieListViewDelegate {
    
    func didSelectMovie(_ movie: Movie.Search) {
        //Next PR's
    }
}

extension MovieListViewController {
    
    func configureNavigationBar() {
        searchController.searchBar.placeholder = "Type a movie name"
        searchController.searchBar.delegate = self
        title = "Movies"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
    }
}

extension MovieListViewController: UISearchBarDelegate {
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard 
            let text = searchBar.text
        else {
            return print("You sould type a name")
        }
        
        let configuration = MovieListViewConfiguration.loading
        self.listView.updateView(with: configuration)
        self.fetchMovies(title: text)
        searchBar.text = ""
    }
}
