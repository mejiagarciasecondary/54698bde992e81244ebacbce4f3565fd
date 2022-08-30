//
//  CharacterListRepositoryError.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation
import Networking
import Common
import Language

public enum CharacterListRepositoryError: AppError {
    case unableToSerializeData
    case unexpectedError(source: NetworkLayerAdapterError?)

    public var description: String {
        switch self {
            case .unableToSerializeData:
                return Lang.Errors.unableToSerializeData

            case .unexpectedError(let source):
                return source?.description ?? Lang.Errors.unexpectedError
        }
    }

    public static func == (
        lhs: CharacterListRepositoryError,
        rhs: CharacterListRepositoryError
    ) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
