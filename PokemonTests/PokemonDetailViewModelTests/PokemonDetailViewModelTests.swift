//
//  PokemonDetailViewModelTests.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import Combine
import XCTest
@testable import Pokemon

class PokemonDetailViewModelTests: XCTestCase {
	var cancellables: Set<AnyCancellable>!
	var viewModel: PokemonDetailViewModel!
	var mockService: MockPokemonService!

	override func setUp() {
		super.setUp()
		cancellables = []
		mockService = MockPokemonService()
		viewModel = PokemonDetailViewModel(pokemonService: mockService, pokemonURL: "https://pokeapi.co/api/v2/pokemon/1/")
	}

	override func tearDown() {
		cancellables = nil
		viewModel = nil
		mockService = nil
		super.tearDown()
	}

	func testFetchPokemonDetailSuccess() {
		let expectation = self.expectation(description: "Fetch Pokemon Detail")

		viewModel.$pokemonDetail
			.dropFirst()
			.sink { detail in
				XCTAssertNotNil(detail)
				XCTAssertEqual(detail?.name, "bulbasaur")
				expectation.fulfill()
			}
			.store(in: &cancellables)

		viewModel.fetchPokemonDetail()

		waitForExpectations(timeout: 1, handler: nil)
	}

	func testFetchPokemonDetailFailure() {
		mockService.shouldReturnError = true

		let expectation = self.expectation(description: "Fetch Pokemon Detail with Error")

		viewModel.$errorMessage
			.dropFirst()
			.sink { errorMessage in
				XCTAssertNotNil(errorMessage)
				expectation.fulfill()
			}
			.store(in: &cancellables)

		viewModel.fetchPokemonDetail()

		waitForExpectations(timeout: 1, handler: nil)
	}
}
