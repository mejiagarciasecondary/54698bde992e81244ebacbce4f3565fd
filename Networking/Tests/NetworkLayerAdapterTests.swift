//
//  NetworkLayerAdapterProtocol.swift
//
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import XCTest
@testable import Networking

final class NetworkLayerAdapterTests: XCTestCase {

    // MARK: - Subject under test

    private var sut: NetworkLayerAdapter?

    // MARK: - Test life cycle

    override func setUp() {
        super.setUp()
        sut = NetworkLayerAdapter()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Tests

    func test_networkAdapter_withInvalidServerStatusCode_shouldReturnExpectedError() async {
        // Arrange
        let testUrl = "https://run.mocky.io/v3/5be9e998-88fb-4c3f-92db-241fe39d48a0"
        let expectedError: NetworkLayerAdapterError = .invalidStatusCodeReceived(
            statusCode: 400
        )

        // Act
        let result = await sut?.execute(
            url: testUrl,
            method: .get,
            body: nil
        )

        // Assert
        switch result {
            case .success, .none:
                XCTFail("This test is meant to fail.")

            case .failure(let error):
                XCTAssertEqual(error, expectedError)
        }
    }

    func test_networkAdapter_withValidServerContent_shouldReturnData() async {
        // Arrange
        let testUrl = "https://jsonplaceholder.typicode.com/todos/1"

        // Act
        let result = await sut?.execute(
            url: testUrl,
            method: .get,
            body: nil
        )

        // Assert
        switch result {
            case .success(let data):
                XCTAssertTrue(data.count > .zero)

            case .failure, .none:
                XCTFail("This test is meant to succeed.")
        }
    }
}
