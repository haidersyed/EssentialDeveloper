//
//  RemoteFeedLoaderTests.swift
//  SwiftEssentialDeveloperTests
//
//  Created by Haider Rizvi on 16/08/2023.
//

import XCTest
@testable import SwiftEssentialDeveloper

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs,[url , url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        client.error = NSError(domain: "Test", code: 0)
        var captureError = [RemoteFeedLoader.Error]()
        sut.load {captureError.append($0)  }
        
        XCTAssertEqual(captureError, [.connectivity])
    }
    
    // MARK: - Helopers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!)-> (sut: RemoteFeedLoader , client: HTTPClientSpy) {
        
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var error: Error?
        
        func get(from url: URL, completion: @escaping (Error) -> Void ) {
            if let error = error {
                completion(error)
            }
            requestedURLs.append(url)
        }
    }
}
