//
//  AppDelegate.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import UIKit
import Repository
import Networking

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureAppApi()
        configureInitialRoute()
        return true
    }

    private func configureAppApi() {
        NetworkLayerAdapter.configure(
            publicKey: ApiCredentials.publicKey,
            privateKey: ApiCredentials.privateKey
        )
    }

    private func configureInitialRoute() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(
            rootViewController: CharacterListViewController(
                viewModel: CharacterListViewModel(
                    repository: CharacterListRepository(
                        networkAdapter: NetworkLayerAdapter()
                    )
                )
            )
        )
        window?.makeKeyAndVisible()
    }
}
