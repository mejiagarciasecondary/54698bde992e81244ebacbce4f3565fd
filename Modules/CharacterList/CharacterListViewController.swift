//
//  CharacterListViewController.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import UIKit
import Language
import Combine
import Repository
import Networking

final class CharacterListViewController: UIViewController {

    // MARK: - UI References

    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?

    // MARK: - Dependencies

    private var tableAdapter: CharacterListTableAdapter?
    private let viewModel: CharacterListViewModel
    private let router: CharacterListRouter
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - View controller life cycle

    init(
        viewModel: CharacterListViewModel,
        router: CharacterListRouter
    ) {
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
        title = Lang.Views.characterList

        tableAdapter = CharacterListTableAdapter(
            dataSource: viewModel,
            cellDelegate: self,
            tableView: tableView
        )
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

                    case .newDataAvailable:
                        self?.tableView?.reloadData()
                        self?.activityIndicator?.stopAnimating()
                }
            }.store(in: &cancellables)
    }
}

// MARK: - CharacterCellDelegate
extension CharacterListViewController: CharacterCellDelegate {
    func characterCellSelected(viewModel: CharacterCellViewModel) {
        guard let characterName = viewModel.name,
              let characterId = viewModel.id else {
            return
        }

        router.routeTo(.detail(id: characterId, name: characterName))
    }
}
