//
//  MarvelBankTests.swift
//  MarvelBankTests
//
//  Created by Luis Carlos Mejia on 29/08/22.
//

import XCTest
import Repository
import Combine
@testable import MarvelBank

final class CharacterListViewModelTests: XCTestCase {

    // MARK: - Subject under test

    private var sut: CharacterListViewModel?

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Test life cycle
    
    override func setUp() {
        sut = CharacterListViewModel(
            repository: MockCharacterListRepository(
                expectedResult: .success([])
            )
        )
    }

    override func tearDown() {
        sut = nil
    }

    // MARK: - Tests

    func test_fetchCharacters_withInvalidRepositoryResponse_shouldReturnExpectedError() {
        // Arrange
        let expectation = XCTestExpectation(description: "ViewModel state")
        var errorReceived: String?

        sut = CharacterListViewModel(
            repository: MockCharacterListRepository(
                expectedResult: .failure(.unableToSerializeData)
            )
        )

        sut?.$state
            .receive(on: RunLoop.main)
            .sink { state in
                switch state {
                    case .error(let message):
                        errorReceived = message
                        expectation.fulfill()

                    case .loading, .idle:
                        return

                    default:
                        XCTFail("Unexpected state received")

                }
            }.store(in: &cancellables)

        // Act
        sut?.viewDidLoad()

        wait(for: [expectation], timeout: 2)

        // Assert
        XCTAssertNotNil(errorReceived)
    }

    func test_fetchCharacters_withValidRepositoryResponse_shouldReturnExpectedCharacters() {
        // Arrange
        let expectation = XCTestExpectation(description: "ViewModel state")

        sut = CharacterListViewModel(
            repository: MockCharacterListRepository(
                expectedResult: .success([.mock(id: 1), .mock(id: 2)])
            )
        )

        sut?.$state
            .receive(on: RunLoop.main)
            .sink { state in
                switch state {
                    case .newDataAvailable:
                        expectation.fulfill()

                    case .loading, .idle:
                        return

                    default:
                        XCTFail("Unexpected state received")

                }
            }.store(in: &cancellables)

        // Act
        sut?.viewDidLoad()

        wait(for: [expectation], timeout: 2)

        // Assert
        XCTAssertFalse(sut?.rows.isEmpty == true)
        XCTAssertEqual(sut?.rows.first?.id, 1)
        XCTAssertEqual(sut?.rows.last?.id, 2)
    }
}

private extension Character {
    static func mock(id: Int) -> Self {
        Character(
            id: id,
            name: nil,
            characterDescription: nil,
            resourceURI: nil,
            thumbnail: nil,
            comics: CharacterCollection(available: .zero),
            series: CharacterCollection(available: .zero)
        )
    }
}
