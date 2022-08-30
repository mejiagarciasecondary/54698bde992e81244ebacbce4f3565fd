//
//  NetworkLayerAdapterProtocol.swift
//
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation

open class NetworkLayerAdapter: NetworkLayerAdapterProtocol {

    // MARK: - Dependencies

    private let urlSession: URLSession
    private let cachePolicy: URLRequest.CachePolicy
    private let timeoutInterval: TimeInterval
    private lazy var networkOperationsQueue = DispatchQueue(
        label: "Networking"
    )

    // MARK: - Class life cycle

    public init(
        urlSession: URLSession = URLSession.shared,
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeoutInterval: TimeInterval = 10
    ) {
        self.urlSession = urlSession
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }

    // MARK: - NetworkLayerAdapterProtocol

    public func execute(
        url: String,
        method: NetworkLayerHttpMethod,
        body: Data?
    ) async -> NetworkExecutionResult {

        guard let url = URL(string: url) else {
            return .failure(.invalidUrl)
        }

        var request = URLRequest(
            url: url,
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )
        request.httpMethod = method.rawValue.uppercased()
        request.httpBody = body

        do {
            let (data, response) = try await URLSession.shared.data(from: request)
            let expectedStatusCodes = (200...299)

            guard let receivedStatusCode = (response as? HTTPURLResponse)?.statusCode else {
                return .failure(.responseNoLegible)
            }

            guard expectedStatusCodes.contains(receivedStatusCode) else {
                return .failure(.invalidStatusCodeReceived(statusCode: receivedStatusCode))
            }

            return .success(data)

        } catch let error {
            return .failure(.unknownError(source: error))
        }
    }
}

// Extension taken from: https://thisdevbrain.com/how-to-use-async-await-with-ios-13/
private extension URLSession {
    func data(from url: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
