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

    private var appRouter = AppRouter()
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
        window?.rootViewController = appRouter.navigationController
        window?.makeKeyAndVisible()

        appRouter.routeTo(.root)
    }
}
