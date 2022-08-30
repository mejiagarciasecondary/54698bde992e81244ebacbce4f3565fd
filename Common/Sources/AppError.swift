//
//  AppError.swift
//
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation
import Language

public protocol AppError: LocalizedError, Equatable {
    var description: String { get }
}

public extension AppError {
    var errorDescription: String? { description }
}
