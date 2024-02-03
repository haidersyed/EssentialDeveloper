//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Haider on 26/01/2024.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
