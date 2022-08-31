//
//  CharacterDetailRepository.swift
//  
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Networking

public final class CharacterDetailRepository: BaseRepository {

    // MARK: - Dependencies

    private let networkAdapter: NetworkLayerAdapterProtocol

    // MARK: - Class lifecycle

    public init(
        networkAdapter: NetworkLayerAdapterProtocol
    ) {
        self.networkAdapter = networkAdapter
    }
}

// MARK: - CharacterListRepository

extension CharacterDetailRepository: CharacterDetailRepositoryProtocol {

    public func fetch(id: Int) async -> Result<Character, CharacterListRepositoryError> {
        let result = await networkAdapter.execute(
            url: CharacterDetailEndpoints.characterDetail(id: id).build(),
            method: .get
        )

        switch result {
            case .success(let data):
                if let serializedResult: CharacterDataWrapper = getSerializedData(data: data),
                   let model = serializedResult.data?.results?.first {
                    return .success(model)
                } else {
                    return .failure(.unableToSerializeData)
                }

            case .failure(let error):
                return .failure(.unexpectedError(source: error))
        }
    }
}
