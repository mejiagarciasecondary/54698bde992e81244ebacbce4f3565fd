//
//  BaseRouter.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 31/08/22.
//

import Foundation
import UIKit
import Language

class BaseRouter<T> {
    
    func routeTo(_ route: T) {}

    func getNavigatorController() -> UINavigationController? { nil }

    func presentError(message: String) {
        let alertController = UIAlertController(
            title: Lang.Errors.title,
            message: message,
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "Ok", style: .default))

        getNavigatorController()?.topViewController?.present(alertController, animated: true)
    }
}
