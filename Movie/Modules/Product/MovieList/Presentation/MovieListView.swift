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
        return tableView
    }()
    
    private var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(tableViewDataSource: UITableViewDataSource, tableViewDelegate: UITableViewDelegate) {
        super.init(frame: .zero)
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        
        self.customizeInterface()
        
        loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        self.tableView.reloadData()
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
