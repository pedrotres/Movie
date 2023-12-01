//
//  MovieListViewControllerTests.swift
//  MovieTests
//
//  Created by pedro tres on 01/12/23.
//

import XCTest

@testable import Movie

final class MovieListViewControllerTests: XCTestCase {
    private let presenterSpy = MovieListPresenterProtocolSpy()
    private lazy var sut = MovieListViewController(presenter: presenterSpy)
    
    func test_loadView() {
        sut.loadView()
        XCTAssertFalse(presenterSpy.didTapSearchCalled)
    }
    
    func test_viewDidLoad() {
        sut.viewDidLoad()
        XCTAssertTrue(presenterSpy.didTapSearchCalled)
    }
    
    func test_showData() {
        XCTAssertEqual(sut.listItems.count, 0)
        
        guard let url = URL(string: "www.google.com.br") else { return }

        sut.showData(Movie(search: [.init(title: "", year: "", imdbID: "", imageURL: url)]))
        
        wait(for: 1)
        
        XCTAssertEqual(sut.listItems.count, 1)
    }
}

final class MovieListPresenterProtocolSpy: MovieListPresenterProtocol {
    var view: MovieListPresenterDelegate?
    
    var interactor: MovieListInteractorProtocol = MovieListInteractorProtocolSpy()
    
    var router: MovieListRouterProtocol = MovieListRouterProtocolSpy()
    
    private(set) var didTapSearchCalled = false
    func didTapSearch(title: String) {
        didTapSearchCalled = true
    }
}

final class MovieListInteractorProtocolSpy: MovieListInteractorProtocol {
    var presenter: MovieListInteractorDelegate?
    
    private(set) var fetchDataCalled = false
    func fetchData(movie: String) {
        fetchDataCalled = true
    }
}

final class MovieListRouterProtocolSpy: MovieListRouterProtocol {
    static func createModule() -> UIViewController {
        return UIViewController()
    }
}
