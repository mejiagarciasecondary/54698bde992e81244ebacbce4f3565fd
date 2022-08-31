//
//  CharacterCollection.swift
//  
//
//  Created by Luis Carlos Mejia on 31/08/22.
//

import Foundation

public struct CharacterCollection: Decodable {
    public let available: Int

    public init(available: Int) {
        self.available = available
    }
}
