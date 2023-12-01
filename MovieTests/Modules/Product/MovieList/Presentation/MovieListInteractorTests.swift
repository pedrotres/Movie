//
//  MovieListInteractorTests.swift
//  MovieTests
//
//  Created by pedro tres on 01/12/23.
//

import XCTest

@testable import Movie

final class MovieListInteractorTests: XCTestCase {
    private let presenterSpy = MovieListInteractorDelegateSpy()
    private let serviceSpy = MovieServiceProtocolSpy()
    private lazy var sut = MovieListInteractor(service: serviceSpy)

    override func setUp() {
        sut.presenter = presenterSpy
    }

    func test_fetchData_returned_success() {
        
        guard let url = URL(string: "www.google.com.br") else { return }
        
        let search = Movie.Search(title: "", year: "", imdbID: "", imageURL: url)
        
        serviceSpy.requestResultToBeReturned = Movie(search: [search])
        sut.fetchData(movie: "")
        XCTAssertTrue(presenterSpy.didFetchDataCalled)
    }

    func test_fetchData_returned_error() {
        sut.fetchData(movie: "")
        XCTAssertFalse(presenterSpy.didFetchDataCalled)
    }
}

final class MovieListInteractorDelegateSpy: MovieListInteractorDelegate {
    
    private(set) var didFetchDataCalled = false
    
    func didFetchData(movie: Movie) {
        didFetchDataCalled = true
    }
}

final class MovieServiceProtocolSpy: MovieServiceProtocol {
    
    var requestResultToBeReturned: Movie?
    
    func fetchMovies(_ name: String, _ completion: @escaping (Movie?) -> Void) {
        completion(requestResultToBeReturned)
    }
}
