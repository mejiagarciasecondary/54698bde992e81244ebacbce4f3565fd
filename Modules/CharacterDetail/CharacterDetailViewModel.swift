//
//  CharacterDetailViewModel.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Repository
import Combine

final class CharacterDetailViewModel {

    // MARK: - Properties

    @Published var state: State = .idle
    private let characterId: Int

    // MARK: - State

    enum State {
        case idle
        case loading
        case error(message: String)
        case newDataAvailable(
            presentation: CharacterDetailViewController.Presentation
        )
    }

    // MARK: - Dependencies

    private let repository: CharacterDetailRepository

    // MARK: - Life cycle

    init(
        characterId: Int,
        repository: CharacterDetailRepository
    ) {
        self.characterId = characterId
        self.repository = repository
    }

    // MARK: - Internal methods

    func viewDidLoad() {
        Task { await fetchData() }
    }

    // MARK: - Private methods

    private func fetchData() async {
        state = .loading

        let fetchedDataResult = await repository.fetch(id: characterId)

        switch fetchedDataResult {
            case .success(let character):
                state = .newDataAvailable(
                    presentation: convertModelToPresentation(
                        model: character
                    )
                )
                return

            case .failure(let error):
                state = .error(message: error.description)
                return
        }
    }

    private func convertModelToPresentation(
        model: Character
    ) -> CharacterDetailViewController.Presentation {
        CharacterDetailViewController.Presentation(
            description: model.characterDescription,
            imageUrl: model.thumbnail?.fileUrl
        )
    }
}
