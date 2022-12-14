//
//  Character.swift
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
    public let comics: CharacterCollection
    public let series: CharacterCollection

    public init(
        id: Int?,
        name: String?,
        characterDescription: String?,
        resourceURI: String?,
        thumbnail: Thumbnail?,
        comics: CharacterCollection,
        series: CharacterCollection
    ) {
        self.id = id
        self.name = name
        self.characterDescription = characterDescription
        self.resourceURI = resourceURI
        self.thumbnail = thumbnail
        self.comics = comics
        self.series = series
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, thumbnail, resourceURI, comics, series
        case characterDescription = "description"
    }
}
