//
//  CharacterListRepository.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation
import Networking

open class CharacterListRepository {

    // MARK: - Dependencies

    private let networkAdapter: NetworkLayerAdapterProtocol

    // MARK: - Class lifecycle

    public init(
        networkAdapter: NetworkLayerAdapterProtocol
    ) {
        self.networkAdapter = networkAdapter
    }

    // MARK: - Private Methods

    private func getSerializedData<T: Decodable>(data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

// MARK: - CharacterListRepository

extension CharacterListRepository: CharacterListRepositoryProtocol {

    public func fetch() async -> Result<[Character], CharacterListRepositoryError>  {
        let result = await networkAdapter.execute(
            url: CharacterListEndpoints.characters.build(),
            method: .get
        )

        switch result {
            case .success(let data):
                if let serializedResult: CharacterDataWrapper = getSerializedData(data: data) {
                    return .success(serializedResult.data?.results ?? [])
                } else {
                    return .failure(.unableToSerializeData)
                }

            case .failure(let error):
                return .failure(.unexpectedError(source: error))
        }
    }
}
