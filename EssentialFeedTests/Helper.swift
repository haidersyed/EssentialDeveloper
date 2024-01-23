//
//  Helper.swift
//  EssentialFeedTests
//
//  Created by Haider Rizvi on 23/01/2024.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
