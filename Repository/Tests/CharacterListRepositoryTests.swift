//
//  CharacterListRepositoryTests.swift
//
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import XCTest
@testable import Repository

final class CharacterListRepositoryTests: XCTestCase {
    
    // MARK: - Subject under test

    private var sut: CharacterListRepository?

    // MARK: - Test life cycle

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: - Tests

    func test_fetchCharacters_withInvalidServerBehavior_shouldReturnExpectedError() async {
        // Arrange
        let expectedError: CharacterListRepositoryError = .unexpectedError(
            source: .invalidUrl
        )

        sut = CharacterListRepository(
            networkAdapter: NetworkLayerAdapterMock(
                expectedResult: .failure(.invalidUrl)
            )
        )

        // Act
        let result = await sut?.fetch()

        // Assert
        switch result {
            case .success, .none:
                XCTFail("This test is meant to fail.")

            case .failure(let error):
                XCTAssertEqual(error, expectedError)
                XCTAssertFalse(error.description.isEmpty)
        }
    }

    func test_fetchCharacters_withInvalidDataResponse_shouldReturnExpectedError() async {
        // Arrange
        let expectedData = "".data(using: .utf8)!
        let expectedError: CharacterListRepositoryError = .unableToSerializeData

        sut = CharacterListRepository(
            networkAdapter: NetworkLayerAdapterMock(
                expectedResult: .success(expectedData)
            )
        )

        // Act
        let result = await sut?.fetch()

        // Assert
        switch result {
            case .success, .none:
                XCTFail("This test is meant to fail.")

            case .failure(let error):
                XCTAssertEqual(error, expectedError)
                XCTAssertFalse(error.description.isEmpty)
        }
    }

    func test_fetchCharacters_ValidDataResponse_shouldReturnExpectedResult() async {
        // Arrange
        let expectedData = """
        {
            "data": {
                "results": [
                    {
                        "id": 123,
                        "name": "test_name",
                        "description": "test_description",
                        "resourceURI": "test_resourceURI",
                        "thumbnail": {
                            "path": "test_path",
                            "extension": "test_extension"
                        }
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        sut = CharacterListRepository(
            networkAdapter: NetworkLayerAdapterMock(
                expectedResult: .success(expectedData)
            )
        )

        // Act
        let result = await sut?.fetch()

        // Assert
        switch result {
            case .success(let characters):
                XCTAssertFalse(characters.isEmpty)
                XCTAssertEqual(characters.first?.id, 123)
                XCTAssertEqual(characters.first?.name, "test_name")
                XCTAssertEqual(characters.first?.characterDescription, "test_description")
                XCTAssertEqual(characters.first?.resourceURI, "test_resourceURI")
                XCTAssertEqual(characters.first?.thumbnail?.path, "test_path")
                XCTAssertEqual(characters.first?.thumbnail?.thumbnailExtension, "test_extension")

            case .failure, .none:
                XCTFail("This test is meant to fail.")
        }
    }
}
