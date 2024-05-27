//
//  PokemonServiceImplTests.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import Combine
import XCTest
@testable import Pokemon

class PokemonServiceImplTests: XCTestCase {
	var cancellables: Set<AnyCancellable>!
	var service: PokemonServiceImpl!
	var mockNetworkManager: MockNetworkManager!

	override func setUp() {
		super.setUp()
		cancellables = []
		mockNetworkManager = MockNetworkManager()
		service = PokemonServiceImpl(networkManager: mockNetworkManager)
	}

	override func tearDown() {
		cancellables = nil
		service = nil
		mockNetworkManager = nil
		super.tearDown()
	}

	func testFetchPokemonListSuccess() {
		let expectation = self.expectation(description: "Fetch Pokemon List")

		service.fetchPokemonList(limit: 100, offset: 0)
			.sink(receiveCompletion: { completion in
				if case .failure(let error) = completion {
					XCTFail("Expected success but got error \(error)")
				}
			}, receiveValue: { response in
				XCTAssertEqual(response.count, 1118)
				expectation.fulfill()
			})
			.store(in: &cancellables)

		waitForExpectations(timeout: 1, handler: nil)
	}

	func testFetchPokemonDetailSuccess() {
		let expectation = self.expectation(description: "Fetch Pokemon Detail")

		service.fetchPokemonDetail(url: "https://pokeapi.co/api/v2/pokemon/1/")
			.sink(receiveCompletion: { completion in
				if case .failure(let error) = completion {
					XCTFail("Expected success but got error \(error)")
				}
			}, receiveValue: { detail in
				XCTAssertEqual(detail.name, "bulbasaur")
				expectation.fulfill()
			})
			.store(in: &cancellables)

		waitForExpectations(timeout: 1, handler: nil)
	}

	func testFetchPokemonListFailure() {
		mockNetworkManager.shouldReturnError = true

		let expectation = self.expectation(description: "Fetch Pokemon List with Error")

		service.fetchPokemonList(limit: 100, offset: 0)
			.sink(receiveCompletion: { completion in
				if case .failure(let error) = completion {
					XCTAssertEqual(error, NetworkError.serverError(500))
					expectation.fulfill()
				}
			}, receiveValue: { _ in
				XCTFail("Expected failure but got success")
			})
			.store(in: &cancellables)

		waitForExpectations(timeout: 1, handler: nil)
	}

	func testFetchPokemonDetailFailure() {
		mockNetworkManager.shouldReturnError = true

		let expectation = self.expectation(description: "Fetch Pokemon Detail with Error")

		service.fetchPokemonDetail(url: "https://pokeapi.co/api/v2/pokemon/1/")
			.sink(receiveCompletion: { completion in
				if case .failure(let error) = completion {
					XCTAssertEqual(error, NetworkError.serverError(500))
					expectation.fulfill()
				}
			}, receiveValue: { _ in
				XCTFail("Expected failure but got success")
			})
			.store(in: &cancellables)

		waitForExpectations(timeout: 1, handler: nil)
	}
}
