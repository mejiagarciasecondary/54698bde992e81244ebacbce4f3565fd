//
//  Endpoint.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

struct Endpoint {
    let url: String
    let version: Int
    let base: String

    func build() -> String {
        "\(base)/v\(version)/\(url)"
    }
}
