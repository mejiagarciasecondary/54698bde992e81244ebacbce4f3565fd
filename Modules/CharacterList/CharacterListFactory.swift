//
//  CharacterListFactory.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Repository
import Networking

struct CharacterListFactory {
    static func make(
        viewModel: CharacterListViewModel,
        router: CharacterListRouter
    ) -> CharacterListViewController {
        CharacterListViewController(
            viewModel: viewModel,
            router: router
        )
    }
}

