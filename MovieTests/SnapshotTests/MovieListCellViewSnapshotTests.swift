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
        //SnapshotTesting.isRecording = true
    }
    
    func test_ActivityCellView() {
        let activityVC = MovieListCellView()
        
        let movieListCellViewConfiguration = MovieListCellViewConfiguration(
            repositoryLabel: "Batman Begins",
            repositoryOwnerLabel: "2005"
        )
        activityVC.updateView(with: movieListCellViewConfiguration)
        
        activityVC.backgroundColor = .white
        
        assertSnapshot(matching: activityVC, as: .image(size: componentSize))
    }
}
