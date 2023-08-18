//
//  RemoteFeedLoaderTests.swift
//  SwiftEssentialDeveloperTests
//
//  Created by Haider Rizvi on 16/08/2023.
//

import XCTest
class RemoteFeedLoader {
    let client:HTTPClient
    let url: URL
    init(url: URL , client: HTTPClient){
        self.client = client
        self.url = url
    }
    func load() {
        client.get(from: URL(string:"https://a-url.com")!)
    }
}


protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}
class RemoteFeedLoaderTests: XCTestCase {

    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteFeedLoader(url: URL(string: "hello.com")!, client: client)
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        
        sut.load()
        XCTAssertEqual(client.requestedURL, url)
    }
}
