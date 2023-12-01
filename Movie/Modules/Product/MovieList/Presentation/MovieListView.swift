//
//  MovieListView.swift
//  Movie
//
//  Created by pedro tres on 30/11/23.
//

import Foundation
import UIKit

protocol MovieListViewDelegate: AnyObject {
    
    func didSelectMovie(_ movie: Movie.Search)
}

final class MovieListView: UIView {
    
    weak var delegate: MovieListViewDelegate?
    
    private let listViewCellIdentifier = "ListViewCellIdentifier"
    
    private var listItems: [Movie.Search] = []
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieListCellView.self, forCellReuseIdentifier: MovieListCellView.classIdentifier())
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        
        super.init(frame: .zero)
        
        self.customizeInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension MovieListView {
    
    func customizeInterface() {
        
        self.backgroundColor = .white
        
        self.configureSubviews()
        self.configureSubviewsConstraints()
        
        let loadingViewConfiguration = LoadingViewConfiguration(textLabel: "Searching repositories...")
        self.loadingView.updateView(with: loadingViewConfiguration)
    }
    
    func configureSubviews() {
        
        self.addSubview(self.tableView)
        self.addSubview(self.loadingView)
    }
    
    func configureSubviewsConstraints() {
        
        NSLayoutConstraint.activate([
            
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.loadingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.loadingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.loadingView.topAnchor.constraint(equalTo: self.topAnchor),
            self.loadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension MovieListView {
    
    func updateView(with configuration: MovieListViewConfiguration) {
        
        switch configuration {
        case .empty:
            showEmpty()
        case .loading:
            showLoading()
        case .list(let repositories):
            showList(repositories: repositories)
        }
    }
    
    func showList(repositories: [Movie.Search]) {
        self.listItems = repositories
        self.tableView.reloadData()
        self.tableView.isHidden = false
        self.loadingView.isHidden = true
    }
    
    func showLoading() {
        self.loadingView.isHidden = false
        self.tableView.isHidden = true
        
    }
    
    func showEmpty() {
        
    }
}

extension MovieListView: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.listItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCellView.classIdentifier(), for: indexPath) as? MovieListCellView
        
        cell?.updateView(with: .init(
            movieTitle: listItems[indexPath.row].title,
            movieYear: listItems[indexPath.row].year
        ))
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MovieListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let repository = listItems[indexPath.row]
        delegate?.didSelectMovie(repository)
    }
}
