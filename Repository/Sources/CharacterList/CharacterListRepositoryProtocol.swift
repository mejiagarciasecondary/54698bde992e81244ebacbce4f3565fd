//
//  CharacterListRepositoryProtocol.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

public protocol CharacterListRepositoryProtocol {
    func fetch() async -> Result<[Character], CharacterListRepositoryError>
}
