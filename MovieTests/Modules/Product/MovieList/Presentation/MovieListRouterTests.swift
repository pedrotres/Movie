//
//  MovieListRouterTests.swift
//  MovieTests
//
//  Created by pedro tres on 01/12/23.
//

import XCTest

@testable import Movie

final class MovieListRouterTests: XCTestCase {
    func test_createModule() {
        let sut = MovieListRouter.createModule()
        XCTAssertTrue(sut is MovieListViewController)
    }
}
