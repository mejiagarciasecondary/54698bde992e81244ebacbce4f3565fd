//
//  CharacterDetailRepositoryProtocol.swift
//  
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation

public protocol CharacterDetailRepositoryProtocol {
    func fetch(id: Int) async -> Result<Character, CharacterListRepositoryError>
}
