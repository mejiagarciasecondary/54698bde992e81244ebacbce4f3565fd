//
//  AppRouter.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Repository
import Networking
import UIKit

final class AppRouter {

    // MARK: - Router properties

    private(set) var navigationController: UINavigationController

    // MARK: - App dependencies

    private lazy var networkAdapterLayer: NetworkLayerAdapterProtocol = NetworkLayerAdapter()

    // MARK: - Routes

    enum Routes {
        case root
    }

    // MARK: - Router life cycle

    init() {
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Internal Methods

    func routeTo(_ route: Routes) {
        switch route {
            case .root:
                navigationController.setViewControllers(
                    [getRootViewController()],
                    animated: true
                )
        }
    }

    // MARK: - Private Methods

    private func getRootViewController() -> UIViewController {
        let viewModel = CharacterListViewModel(
            repository: CharacterListRepository(
                networkAdapter: networkAdapterLayer
            )
        )

        return CharacterListFactory.make(
            viewModel: viewModel,
            router: CharacterListRouter(
                navigationController: navigationController,
                networkAdapterLayer: networkAdapterLayer
            )
        )
    }
}
