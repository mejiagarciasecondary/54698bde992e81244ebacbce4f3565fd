//
//  CharacterDetailFactory.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Repository
import Networking

struct CharacterDetailFactory {
    static func make(
        id: Int,
        name: String,
        networkLayerAdapter: NetworkLayerAdapterProtocol
    ) -> CharacterDetailViewController {
        CharacterDetailViewController(
            characterName: name,
            viewModel: CharacterDetailViewModel(
                characterId: id,
                repository: CharacterDetailRepository(
                    networkAdapter: networkLayerAdapter
                )
            )
        )
    }
}
