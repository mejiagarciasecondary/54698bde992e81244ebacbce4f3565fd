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
    public let name, characterDescription, resourceURI: String?
    public let thumbnail: Thumbnail?

    private enum CodingKeys: String, CodingKey {
        case id, name, thumbnail, resourceURI
        case characterDescription = "description"
    }
}
