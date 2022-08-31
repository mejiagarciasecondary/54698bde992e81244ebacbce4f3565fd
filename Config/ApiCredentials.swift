//
//  ApiCredentials.swift
//  MarvelBank
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation

struct ApiCredentials {
    static var publicKey: String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: "PUBLIC_KEY") else {
            return String()
        }

        return object as? String ?? String()
    }

    static var privateKey: String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: "PRIVATE_KEY") else {
            return String()
        }

        return object as? String ?? String()
    }
}
