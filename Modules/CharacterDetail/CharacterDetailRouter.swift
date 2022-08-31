//
//  CharacterDetailRouter.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 31/08/22.
//

import Foundation
import Repository
import Networking
import UIKit

final class CharacterDetailRouter: BaseRouter<CharacterDetailRouter.Routes> {

    // MARK: - Router properties

    private var navigationController: UINavigationController
    private let networkAdapterLayer: NetworkLayerAdapterProtocol

    // MARK: - Routes

    enum Routes {}

    // MARK: - Router life cycle

    init(
        navigationController: UINavigationController,
        networkAdapterLayer: NetworkLayerAdapterProtocol
    ) {
        self.navigationController = navigationController
        self.networkAdapterLayer = networkAdapterLayer
    }

    // MARK: - Internal Methods

    override func getNavigatorController() -> UINavigationController? {
        navigationController
    }
}
