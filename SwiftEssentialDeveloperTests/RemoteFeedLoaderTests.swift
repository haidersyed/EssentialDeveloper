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
        
        sut.load { _ in}
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in}
        sut.load { _ in}
        
        XCTAssertEqual(client.requestedURLs,[url , url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
  
        var captureError = [RemoteFeedLoader.Error]()
        sut.load {captureError.append($0)  }
        
        let clientError = NSError(domain: "Test", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(captureError, [.connectivity])
    }
    
    // MARK: - Helopers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!)-> (sut: RemoteFeedLoader , client: HTTPClientSpy) {
        
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut,client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        
        
        private var messages = [(url: URL,  completion: (Error) -> Void)]()
        
        var requestedURLs: [URL] {
            return messages.map { $0.url}
        }
        
        func get(from url: URL, completion: @escaping (Error) -> Void ) {
            messages.append((url,completion))
        }
        
        func complete(with error: Error, at index: Int = 0){
            messages[index].completion(error)
        }
    }
  
}
