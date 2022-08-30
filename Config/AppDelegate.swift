//
//  AppDelegate.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        configureInitialRoute()
        return true
    }

    private func configureInitialRoute() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = CharacterListViewController()
        window?.makeKeyAndVisible()
    }
}

