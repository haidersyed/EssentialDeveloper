//
//  RemoteFeedLoaderTests.swift
//  SwiftEssentialDeveloperTests
//
//  Created by Haider Rizvi on 16/08/2023.
//

import XCTest
class RemoteFeedLoader {
    let client:HTTPClient
    init(client: HTTPClient){
        self.client = client
    }
    func load() {
        client.get(from: URL(string:"https://a-url.com")!)
    }
}


class HTTPClient {
    static var shared = HTTPClient()
   
    func get(from url: URL) {}
}

class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    
   override func get(from url: URL) {
        requestedURL = url
    }
}
class RemoteFeedLoaderTests: XCTestCase {

    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = RemoteFeedLoader(client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = RemoteFeedLoader(client: client)
        
        sut.load()
        XCTAssertNotNil(client.requestedURL)
    }
}
