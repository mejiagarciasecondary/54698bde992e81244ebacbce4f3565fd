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

    private lazy var tableAdapter = CharacterListTableAdapter(
        dataSource: viewModel,
        tableView: tableView
    )

    private let viewModel: CharacterListViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []

    // MARK: - View controller life cycle

    init(
        viewModel: CharacterListViewModelProtocol
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
        viewModel.viewDidLoad()
        subscribeToViewModelState()
    }

    // MARK: - Private Methods

    private func setupUI() {
        title = Lang.Views.characterList
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func subscribeToViewModelState() {
        viewModel
            .statePublisher
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
                        self?.activityIndicator?.stopAnimating()
                        self?.tableView?.reloadData()
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
