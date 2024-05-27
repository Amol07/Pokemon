//
//  PokemonListViewModelTests.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import Combine
import XCTest
@testable import Pokemon

class PokemonListViewModelTests: XCTestCase {
	var cancellables: Set<AnyCancellable>!
	var viewModel: PokemonListViewModel!
	var mockService: MockPokemonService!

	override func setUp() {
		super.setUp()
		cancellables = []
		mockService = MockPokemonService()
		viewModel = PokemonListViewModel(pokemonService: mockService)
	}

	override func tearDown() {
		cancellables = nil
		viewModel = nil
		mockService = nil
		super.tearDown()
	}

	func testFetchPokemonListSuccess() {
		let expectation = self.expectation(description: "Fetch Pokemon List with Success")

		viewModel.$pokemonList
			.dropFirst()
			.sink { pokemons in
				XCTAssertEqual(pokemons.count, 10)
				XCTAssertEqual(pokemons.first?.name, "bulbasaur")
				expectation.fulfill()
			}
			.store(in: &cancellables)

		viewModel.fetchPokemonList()

		waitForExpectations(timeout: 1, handler: nil)
	}

	func testFetchPokemonListFailure() {
		mockService.shouldReturnError = true

		let expectation = self.expectation(description: "Fetch Pokemon List with Error")

		viewModel.$errorMessage
			.dropFirst()
			.sink { errorMessage in
				XCTAssertNotNil(errorMessage)
				expectation.fulfill()
			}
			.store(in: &cancellables)

		viewModel.fetchPokemonList()

		waitForExpectations(timeout: 1, handler: nil)
	}

	func testLoadMorePokemons() {
		let initialExpectation = self.expectation(description: "Initial Fetch Pokemon List")
		let loadMoreExpectation = self.expectation(description: "Load More Pokemons")

		viewModel.$pokemonList
			.dropFirst()
			.sink { pokemons in
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					if pokemons.count == 10 {
						initialExpectation.fulfill()
					} else if pokemons.count == 20 {
						loadMoreExpectation.fulfill()
					} else {
						XCTFail("Please check the implementation and mock data")
					}
				}
			}
			.store(in: &cancellables)

		viewModel.fetchPokemonList()

		wait(for: [initialExpectation], timeout: 5)

		// Simulate loading more pokemons
		viewModel.loadMorePokemons()

		wait(for: [loadMoreExpectation], timeout: 5)
	}

	func testSortById() {
		let expectation = self.expectation(description: "Sort by Id")

		viewModel.$pokemonList
			.dropFirst()
			.sink { _ in
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					self.viewModel?.pokemonList.insert(Pokemon(name: "metapod", url: "https://pokeapi.co/api/v2/pokemon/11/", id: 11), at: 0)
					self.viewModel?.sortById()
					XCTAssertEqual(self.viewModel?.pokemonList.map { $0.id }, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
					expectation.fulfill()
				}
			}
			.store(in: &cancellables)

		viewModel.fetchPokemonList()

		waitForExpectations(timeout: 5, handler: nil)
	}

	func testFilteredPokemonList() {
		let expectation = self.expectation(description: "Filter Pokemon List")

		viewModel.$pokemonList
			.dropFirst()
			.sink { _ in
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
					let unFilteredList = self.viewModel.filteredPokemonList()
					XCTAssertEqual(unFilteredList.count, 10)
					self.viewModel?.searchText = "bulba"
					let filteredList = self.viewModel?.filteredPokemonList()
					XCTAssertEqual(filteredList?.count, 1)
					XCTAssertEqual(filteredList?.first?.name, "bulbasaur")
					expectation.fulfill()
				}
			}
			.store(in: &cancellables)

		viewModel.fetchPokemonList()

		waitForExpectations(timeout: 5, handler: nil)
	}
}
