//
//  CharacterListViewModel.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Repository
import Combine

protocol CharacterListViewModelProtocol: CharacterListTableAdapterDataSource {
    var statePublisher: Published<CharacterListViewModelState>.Publisher { get }

    func viewDidLoad()

    init(
        repository: CharacterListRepository
    )
}

enum CharacterListViewModelState {
    case idle
    case loading
    case error(message: String)
    case newDataAvailable
}

final class CharacterListViewModel: CharacterListViewModelProtocol {

    // MARK: - Properties

    var statePublisher: Published<CharacterListViewModelState>.Publisher { $state }
    @Published private var state: CharacterListViewModelState = .idle
    private(set) var rows = [CharacterCellViewModel]()

    // MARK: - Dependencies

    private let repository: CharacterListRepository

    // MARK: - Life cycle

    init(
        repository: CharacterListRepository
    ) {
        self.repository = repository
    }

    // MARK: - Internal methods

    func viewDidLoad() {
        Task { await fetchData() }
    }

    // MARK: - Private methods

    private func fetchData() async {
        state = .loading

        let fetchedDataResult = await repository.fetch()

        switch fetchedDataResult {
            case .success(let characters):
                rows = mapServerModelsToRowModels(characters)
                state = .newDataAvailable
                return

            case .failure(let error):
                state = .error(message: error.description)
                return
        }
    }

    private func mapServerModelsToRowModels(
        _ serverModels: [Character]
    ) -> [CharacterCellViewModel] {
        serverModels.map { item in
            CharacterCellViewModel(name: item.name)
        }
    }
}
