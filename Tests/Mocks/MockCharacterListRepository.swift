//
//  MockCharacterListRepository.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 31/08/22.
//

import XCTest
import Repository
import Combine

struct MockCharacterListRepository: CharacterListRepositoryProtocol {
    let expectedResult: Result<[Character], CharacterListRepositoryError>

    func fetch() async -> Result<[Character], CharacterListRepositoryError> {
        expectedResult
    }
}
