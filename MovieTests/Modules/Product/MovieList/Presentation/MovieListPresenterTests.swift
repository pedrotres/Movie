//
//  MovieListPresenterTests.swift
//  MovieTests
//
//  Created by pedro tres on 01/12/23.
//

import XCTest

@testable import Movie

final class MovieListPresenterTests: XCTestCase {

    private let interactorSpy = MovieListInteractorProtocolSpy()
    private let routerSpy = MovieListRouterProtocolSpy()
    private let viewContollerSpy = MovieListPresenterDelegateSpy()
    private lazy var sut = MovieListPresenter(interactor: interactorSpy, router: routerSpy)
    
    override func setUp() {
        super.setUp()
        sut.view = viewContollerSpy
    }

    func test_didTapSearch() {
        sut.didTapSearch(title: "")
        XCTAssertTrue(interactorSpy.fetchDataCalled)
    }

    func test_didFetchData() {
        sut.didFetchData(movie: Movie(search: []))
        XCTAssertTrue(viewContollerSpy.showDataCalled)
    }
}

final class MovieListPresenterDelegateSpy: MovieListPresenterDelegate {
    
    private(set) var showDataCalled = false
    
    func showData(_ movie: Movie) {
        showDataCalled = true
    }
}
