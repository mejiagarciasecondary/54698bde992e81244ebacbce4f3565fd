//
//  Thumbnail.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

public struct Thumbnail: Decodable {
    public let path: String
    public let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
