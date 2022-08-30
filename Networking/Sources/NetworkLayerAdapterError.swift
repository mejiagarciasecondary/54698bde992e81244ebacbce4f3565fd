//
//  NetworkLayerAdapterError.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation
import Language
import Common

public enum NetworkLayerAdapterError: AppError {
    case invalidUrl
    case responseNoLegible
    case invalidStatusCodeReceived(statusCode: Int)
    case unknownError(source: Error?)

    public var description: String {
        switch self {
            case .invalidUrl:
                return Lang.Errors.invalidUrl

            case .responseNoLegible:
                return Lang.Errors.responseNoLegible

            case .invalidStatusCodeReceived(let statusCode):
                return String(format: Lang.Errors.unexpectedStatusCode, statusCode)
                
            case .unknownError(let source):
                return source?.localizedDescription ?? .init()
        }
    }

    public static func == (
        lhs: NetworkLayerAdapterError,
        rhs: NetworkLayerAdapterError
    ) -> Bool {
        String(describing: lhs) == String(describing: rhs)
    }
}
