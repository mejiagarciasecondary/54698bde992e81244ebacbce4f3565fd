//
//  NetworkLayerAdapterProtocol.swift
//  
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

public typealias NetworkExecutionResult<T> = Result<T?, NetworkLayerAdapterError>

/// Protocol used by our main adapter,
/// although can be implemented for mocking this layer.
public protocol NetworkLayerAdapterProtocol {
    func execute<ExpectedResult: Decodable>(
        url: String,
        method: NetworkLayerHttpMethod,
        body: Data?
    ) async -> NetworkExecutionResult<ExpectedResult>
}

/// Since this is a technical test, we don't need more methods to support.
public enum NetworkLayerHttpMethod: String {
    case `get`
}
