//
//  NetworkLayerAdapterMock.swift
//  
//
//  Created by Luis Carlos Mejia on 30/08/22.
//

import Foundation
import Networking

struct NetworkLayerAdapterMock: NetworkLayerAdapterProtocol {
    let expectedResult: Result<Data, NetworkLayerAdapterError>

    func execute(
        url: String,
        method: NetworkLayerHttpMethod
    ) async -> NetworkExecutionResult {
        return expectedResult
    }
}
