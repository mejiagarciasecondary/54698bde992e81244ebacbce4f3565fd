//
//  CharacterDetailViewController.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import UIKit
import Language
import Combine

final class CharacterDetailViewController: UIViewController {

    // MARK: - UI References

    @IBOutlet private weak var mainImageView: UIImageView?
    @IBOutlet private weak var characterNameLabel: UILabel?
    @IBOutlet private weak var characterDescriptionLabel: UILabel?
    @IBOutlet private weak var totalComicsLabel: UILabel?
    @IBOutlet private weak var totalSeriesLabel: UILabel?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?

    // MARK: - Presentation

    struct Presentation {
        let description: String
        let imageUrl: String
        let totalSeries: Int
        let totalComics: Int
    }

    // MARK: - Dependencies

    private let viewModel: CharacterDetailViewModel
    private var cancellables: Set<AnyCancellable> = []
    private let characterName: String
    private let router: CharacterDetailRouter

    // MARK: - View controller life cycle

    init(
        characterName: String,
        viewModel: CharacterDetailViewModel,
        router: CharacterDetailRouter
    ) {
        self.characterName = characterName
        self.viewModel = viewModel
        self.router = router

        super.init(
            nibName: String(describing: Self.self),
            bundle: .main
        )
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribeToViewModelState()
        viewModel.viewDidLoad()
    }

    // MARK: - Private Methods

    private func setupUI() {
        title = characterName
    }

    private func subscribeToViewModelState() {
        viewModel
            .$state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                    case .idle:
                        return

                    case .loading:
                        self?.activityIndicator?.startAnimating()

                    case .error(let message):
                        self?.activityIndicator?.stopAnimating()
                        self?.router.presentError(message: message)

                    case .newDataAvailable(let presentation):
                        self?.setupPresentation(presentation)
                        self?.activityIndicator?.stopAnimating()
                }
            }.store(in: &cancellables)
    }

    private func setupPresentation(_ presentation: Presentation) {
        characterDescriptionLabel?.text = presentation.description
        totalComicsLabel?.text = "\(presentation.totalComics)"
        totalSeriesLabel?.text = "\(presentation.totalSeries)"
        mainImageView?.load(url: presentation.imageUrl)
    }
}
