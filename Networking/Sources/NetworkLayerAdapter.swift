//
//  NetworkLayerAdapterProtocol.swift
//
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import Foundation
import Common

open class NetworkLayerAdapter {

    // MARK: - Dependencies

    private let urlSession: URLSession
    private let cachePolicy: URLRequest.CachePolicy
    private let timeoutInterval: TimeInterval

    private struct Credentials {
        static var publicKey = String()
        static var privateKey = String()
    }

    // MARK: - Constants
    private enum Constants: String {
        case contentType = "Content-Type"
        case applicationJson = "application/json; charset=utf-8"
        case apiKey = "apikey"
        case hash
        case timeStamp = "ts"
    }

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

    // MARK: - Internal Methods

    func getUrlWithQueryParameters(
        url: URL
    ) -> URL {
        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        )

        let timeStamp = Date().timeIntervalSince1970

        components?.queryItems = [
            URLQueryItem(
                name: Constants.timeStamp.rawValue,
                value: "\(timeStamp)"
            ),
            URLQueryItem(
                name: Constants.apiKey.rawValue,
                value: NetworkLayerAdapter.Credentials.publicKey
            ),
            URLQueryItem(
                name: Constants.hash.rawValue,
                value: generateHash(timeStamp: timeStamp)
            )
        ]

        return components?.url ?? url
    }

    // MARK: - Private Methods

    private func createURLRequest(
        using url: URL,
        method: NetworkLayerHttpMethod
    ) -> URLRequest {
        var request = URLRequest(
            url: getUrlWithQueryParameters(url: url),
            cachePolicy: cachePolicy,
            timeoutInterval: timeoutInterval
        )
        request.httpMethod = method.rawValue.uppercased()
        request.allHTTPHeaderFields = [
            Constants.contentType.rawValue: Constants.applicationJson.rawValue,
        ]

        return request
    }

    // MARK: - Static methods

    public static func configure(
        publicKey: String,
        privateKey: String
    ) {
        Credentials.publicKey = publicKey
        Credentials.privateKey = privateKey
    }

    private func generateHash(timeStamp: Double) -> String {
        "\(timeStamp)\(Credentials.privateKey)\(Credentials.publicKey)".md5
    }
}

// MARK: - NetworkLayerAdapterProtocol

extension NetworkLayerAdapter: NetworkLayerAdapterProtocol {

    public func execute(
        url: String,
        method: NetworkLayerHttpMethod
    ) async -> NetworkExecutionResult {

        guard let url = URL(string: url) else {
            return .failure(.invalidUrl)
        }

        let request = createURLRequest(
            using: url,
            method: method
        )

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
