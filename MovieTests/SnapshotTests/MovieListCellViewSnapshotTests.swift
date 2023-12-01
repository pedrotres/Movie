//
//  MovieListCellViewSnapshotTests.swift
//  MovieTests
//
//  Created by pedro tres on 30/11/23.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import Movie

final class MovieListCellViewSnapshotTests: XCTestCase {
    
    let componentSize = CGSize(width: 414, height: 100)
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
    }
    
    func test_ActivityCellView() {
        let activityVC = MovieListCellView()
        
        let movieListCellViewConfiguration = MovieListCellViewConfiguration(
            movieTitle: "Batman Begins",
            movieYear: "2005",
            imageURL: URL(string: "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg")!
        )
        activityVC.updateView(with: movieListCellViewConfiguration)
        
        activityVC.backgroundColor = .white
        
        assertSnapshot(matching: activityVC, as: .image(size: componentSize))
    }
}
