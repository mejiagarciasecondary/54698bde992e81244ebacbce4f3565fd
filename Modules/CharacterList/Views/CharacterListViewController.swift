//
//  CharacterListViewController.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import UIKit
import Language
import Combine

final class CharacterListViewController: UIViewController {

    // MARK: - UI References

    @IBOutlet private weak var tableView: UITableView?
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView?

    // MARK: - Dependencies

    private var tableAdapter: CharacterListTableAdapter?
    private let viewModel: CharacterListViewModel
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - View controller life cycle

    init(
        viewModel: CharacterListViewModel
    ) {
        self.viewModel = viewModel

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

                    case .error(message: let message):
                        self?.activityIndicator?.stopAnimating()
                        self?.showErrorMessage(message: message)

                    case .newDataAvailable:
                        self?.tableView?.reloadData()
                        self?.activityIndicator?.stopAnimating()
                }
            }.store(in: &cancellables)
    }

    private func showErrorMessage(message: String) {
        let alertController = UIAlertController(
            title: Lang.Errors.title,
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Ok", style: .default))

        present(alertController, animated: true)
    }
}

// MARK: - CharacterCellDelegate
extension CharacterListViewController: CharacterCellDelegate {
    func characterCellSelected(viewModel: CharacterCellViewModel) {
        print(viewModel.id)
    }
}
