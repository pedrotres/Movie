//
//  LoadingViewSnapshotTests.swift
//  MovieTests
//
//  Created by pedro tres on 30/11/23.
//

import Foundation
import XCTest
import SnapshotTesting

@testable import Movie

final class LoadingViewSnapshotTests: XCTestCase {
    
    let componentSize = CGSize(width: 300, height: 150)
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
    }
    
    func test_LoadingView() {
        let activityVC = LoadingView()
        
        let loadingViewConfiguration = LoadingViewConfiguration(textLabel: "Loading...")
        activityVC.updateView(with: loadingViewConfiguration)
        
        activityVC.backgroundColor = .white
        
        assertSnapshot(matching: activityVC, as: .image(size: componentSize))
    }
}
