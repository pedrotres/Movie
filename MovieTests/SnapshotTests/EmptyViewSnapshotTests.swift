//
//  EmptyViewSnapshotTests.swift
//  MovieTests
//
//  Created by pedro tres on 30/11/23.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import Movie

final class EmptyViewSnapshotTests: XCTestCase {
    
    let componentSize = CGSize(width: 414, height: 100)
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
    }
    
    func test_EmptyView() {
        let activityVC = EmptyView()
        
        let emptyViewConfiguration = EmptyViewConfiguration(
            title: "Error!",
            description: "Movie not found"
        )
        
        activityVC.updateView(with: emptyViewConfiguration)
        
        activityVC.backgroundColor = .white
        
        assertSnapshot(matching: activityVC, as: .image(size: componentSize))
    }
}
