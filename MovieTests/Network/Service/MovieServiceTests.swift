//
//  MovieService.swift
//  MovieTests
//
//  Created by pedro tres on 29/11/23.
//

import Foundation

import XCTest
@testable import Movie

final class MovieServiceTests: XCTestCase {
    
    private let networkSpy = NetworkClientSpy()
    private let dataWithError = "".data(using: .utf8)
    private let fetchMoviesUrlString = "https://www.omdbapi.com/?s=&apikey=15ef78e5"
    private lazy var sut = MovieService(networkClient: networkSpy)
    
    func test_fetchMovies_shouldCallWithSuccess() {
        networkSpy.dataToBeReturned = movieDataJson
        
        let mockedMovieList =  Movie(search: [.init(
            title: "Batman Begins",
            year: "2005",
            imdbID: "tt0372784",
            imageURL: URL(string: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!
        )])
        
        sut.fetchMovies("") { movielist in
            XCTAssertEqual(movielist, mockedMovieList)
        }
    }
    
    func test_fetchMovies_whenIncomingDataIsNil_shouldReturnNilOnCompletion() {
        networkSpy.dataToBeReturned = nil
        sut.fetchMovies("") { contactList in
            
            XCTAssertNil(contactList)
        }
    }
    
    func test_fetchMovies_givenUrl_shouldPassCorrectURLToPerformRequest() {
         sut.fetchMovies("") { _ in }
        guard let passedUrlString = networkSpy.performRequestPassed?.description else { return }
         
         XCTAssertEqual(passedUrlString, fetchMoviesUrlString)
     }
     
     func test_fetchMovies_whenIncomingDataIsNotNil_whenDecodeFails_shouldReturnNilOnCompletion() {
         networkSpy.dataToBeReturned = dataWithError
         sut.fetchMovies("") { contactList in
             
             XCTAssertNil(contactList)
         }
     }
}
