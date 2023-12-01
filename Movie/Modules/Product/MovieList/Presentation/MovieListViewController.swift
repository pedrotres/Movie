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
        let listView = MovieListView(
            tableViewDataSource: self,
            tableViewDelegate: self
        )
        listView.delegate = self
        return listView
    }()
    
    lazy var searchController = UISearchController(searchResultsController: nil)
    
    private var listItems: [Movie.Search] = []
    
    var presenter: MovieListPresenterProtocol
    
    init(presenter: MovieListPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didTapSearch(title: "Batman")
        self.configureNavigationBar()
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
        presenter.didTapSearch(title: text)
        searchBar.text = ""
    }
}

extension MovieListViewController: MovieListPresenterDelegate {
    func showData(_ movie: Movie) {
        
        DispatchQueue.main.async {
            self.listItems = movie.search
            let configuration = MovieListViewConfiguration.list(movie.search)
            self.listView.updateView(with: configuration)
        }
    }
}

extension MovieListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCellView.classIdentifier(), for: indexPath) as? MovieListCellView
        
        cell?.updateView(with: .init(
            movieTitle: listItems[indexPath.row].title,
            movieYear: listItems[indexPath.row].year,
            imageURL: listItems[indexPath.row].imageURL
        ))
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
    }
}
