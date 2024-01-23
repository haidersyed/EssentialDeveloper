//
//  FeedItem.swift
//  SwiftEssentialDeveloper
//
//  Created by Haider Rizvi on 14/08/2023.
//

import Foundation

internal struct FeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
