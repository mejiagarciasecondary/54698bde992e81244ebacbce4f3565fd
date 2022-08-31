//
//  CharacterDetailEndpoints.swift
//  
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation

struct CharacterDetailEndpoints {
    static func characterDetail(id: Int) -> Endpoint {
        Endpoint(
            url: "public/characters/\(id)",
            version: 1,
            base: "https://gateway.marvel.com"
        )
    }
}
