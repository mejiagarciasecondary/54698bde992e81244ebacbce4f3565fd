//
//  CharacterListEndpoints.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

struct CharacterListEndpoints {
    static let characters = Endpoint(
        url: "public/characters",
        version: 1,
        base: "https://gateway.marvel.com"
    )
}
