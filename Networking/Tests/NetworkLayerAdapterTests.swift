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

    func test_executeRequest_withInvalidServerStatusCode_shouldReturnExpectedError() async {
        // Arrange
        let testUrl = "https://run.mocky.io/v3/5be9e998-88fb-4c3f-92db-241fe39d48a0"
        let expectedError: NetworkLayerAdapterError = .invalidStatusCodeReceived(
            statusCode: 400
        )

        // Act
        let result = await sut?.execute(
            url: testUrl,
            method: .get
        )

        // Assert
        switch result {
            case .success, .none:
                XCTFail("This test is meant to fail.")

            case .failure(let error):
                XCTAssertEqual(error, expectedError)
                XCTAssertFalse(error.description.isEmpty)
        }
    }

    func test_executeRequest_withValidServerContent_shouldReturnData() async {
        // Arrange
        let testUrl = "https://jsonplaceholder.typicode.com/todos/1"

        // Act
        let result = await sut?.execute(
            url: testUrl,
            method: .get
        )

        // Assert
        switch result {
            case .success(let data):
                XCTAssertTrue(data.count > .zero)

            case .failure, .none:
                XCTFail("This test is meant to succeed.")
        }
    }

    func test_createURL_withApiKey_shouldCreateExpectedQueryParams() async {
        // Arrange
        let mockPublicKey = "2123345634745723"
        let mockPrivateKey = "3463746345345"
        let mockUrl = URL(string: "https://google.com")!

        // Act
        NetworkLayerAdapter.configure(publicKey: mockPublicKey, privateKey: mockPrivateKey)
        let url = sut?.getUrlWithQueryParameters(url: mockUrl)

        // Assert
        XCTAssertTrue(url?.query?.contains("apikey=2123345634745723") == true)
        XCTAssertTrue(url?.query?.contains("ts=") == true)
        XCTAssertTrue(url?.query?.contains("hash=") == true)
    }
}
