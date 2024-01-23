//
//  FeedLoader.swift
//  SwiftEssentialDeveloper
//
//  Created by Haider Rizvi on 14/08/2023.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping(LoadFeedResult) -> Void)
}
