//
//  CharacterDetailViewModelTests.swift
//  MarvelBankTests
//
//  Created by Luis Carlos Mejia on 31/08/22.
//

import XCTest
import Repository
import Combine
@testable import MarvelBank

final class CharacterDetailViewModelTests: XCTestCase {

    // MARK: - Subject under test

    private var sut: CharacterDetailViewModel?

    private var cancellables: Set<AnyCancellable> = []

    // MARK: - Test life cycle

    override func setUp() {
        sut = CharacterDetailViewModel(
            characterId: 1,
            repository: MockCharacterDetailRepository(
                expectedResult: .success(.mock)
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

        sut = CharacterDetailViewModel(
            characterId: 1,
            repository: MockCharacterDetailRepository(
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
        var presentationReceived: CharacterDetailViewController.Presentation?

        sut?.$state
            .receive(on: RunLoop.main)
            .sink { state in
                switch state {
                    case .idle, .loading:
                        return

                    case .newDataAvailable(let presentation):
                        presentationReceived = presentation
                        expectation.fulfill()

                    default:
                        XCTFail("Unexpected state received")
                }
            }.store(in: &cancellables)

        // Act
        sut?.viewDidLoad()

        wait(for: [expectation], timeout: 2)

        // Assert
        XCTAssertNotNil(presentationReceived)
        XCTAssertEqual(presentationReceived?.description, "test_desc")
        XCTAssertEqual(presentationReceived?.totalComics, 10)
        XCTAssertEqual(presentationReceived?.totalSeries, 20)
    }
}

private extension Character {
    static var mock: Self {
        Character(
            id: nil,
            name: nil,
            characterDescription: "test_desc",
            resourceURI: "url",
            thumbnail: nil,
            comics: CharacterCollection(available: 10),
            series: CharacterCollection(available: 20)
        )
    }
}
