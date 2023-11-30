//
//  NetworkClientSpy.swift
//  MovieTests
//
//  Created by pedro tres on 30/11/23.
//

import Foundation

@testable import Movie

final class NetworkClientSpy: NetworkClientProtocol {
    
    private(set) var performRequestCalled: Bool = false
    private(set) var performRequestCallCount: Int = 0
    private(set) var performRequestPassed: URL?
    var dataToBeReturned: Data?
    
    func performRequest(with url: URL, completion: @escaping (Data?) -> ()) {
        performRequestCalled = true
        performRequestPassed = url
        performRequestCallCount += 1
        completion(dataToBeReturned)
    }
}
