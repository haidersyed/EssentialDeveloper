//
//  FeedLoader.swift
//  SwiftEssentialDeveloper
//
//  Created by Haider Rizvi on 14/08/2023.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
    
}
