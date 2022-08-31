//
//  CharacterListRouter.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Repository
import Networking
import UIKit

final class CharacterListRouter: BaseRouter<CharacterListRouter.Routes> {

    // MARK: - Router properties

    private var navigationController: UINavigationController
    private let networkAdapterLayer: NetworkLayerAdapterProtocol

    // MARK: - Routes

    enum Routes {
        case detail(id: Int, name: String)
    }

    // MARK: - Router life cycle

    init(
        navigationController: UINavigationController,
        networkAdapterLayer: NetworkLayerAdapterProtocol
    ) {
        self.navigationController = navigationController
        self.networkAdapterLayer = networkAdapterLayer
    }

    // MARK: - Internal Methods

    override func routeTo(_ route: Routes) {
        switch route {
            case .detail(let id, let name):
                navigationController.pushViewController(
                    CharacterDetailFactory.make(
                        id: id,
                        name: name,
                        networkLayerAdapter: networkAdapterLayer,
                        router: CharacterDetailRouter(
                            navigationController: navigationController,
                            networkAdapterLayer: networkAdapterLayer
                        )
                    ),
                    animated: true
                )
        }
    }

    override func getNavigatorController() -> UINavigationController? {
        navigationController
    }
}
