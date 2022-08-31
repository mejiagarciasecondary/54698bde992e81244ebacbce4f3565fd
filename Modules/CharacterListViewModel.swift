//
//  CharacterListViewModel.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Repository
import Combine

final class CharacterListViewModel: CharacterListTableAdapterDataSource {

    // MARK: - Properties

    @Published var state: State = .idle
    private(set) var rows = [CharacterCellViewModel]()

    // MARK: - State

    enum State {
        case idle
        case loading
        case error(message: String)
        case newDataAvailable
    }

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
            CharacterCellViewModel(
                id: item.id,
                name: item.name,
                imageUrlString: item.thumbnail?.fileUrl
            )
        }
    }
}
