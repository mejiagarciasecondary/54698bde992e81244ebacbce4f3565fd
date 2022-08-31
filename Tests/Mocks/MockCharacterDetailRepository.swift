//
//  MockCharacterDetailRepository.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 31/08/22.
//

import XCTest
import Repository
import Combine

struct MockCharacterDetailRepository: CharacterDetailRepositoryProtocol {
    let expectedResult: Result<Character, CharacterListRepositoryError>

    func fetch(id: Int) async -> Result<Character, CharacterListRepositoryError> {
        expectedResult
    }
}
