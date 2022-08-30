//
//  Character+Models.swift
//
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

// MARK: - Character

public struct Character: Decodable {
    public let id: Int?
    public let name, characterDescription: String?
    public let thumbnail: Thumbnail?

    private enum CodingKeys: String, CodingKey {
        case id, name, thumbnail
        case characterDescription = "description"
    }
}

public struct Thumbnail: Decodable {
    public let path: String
    public let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
