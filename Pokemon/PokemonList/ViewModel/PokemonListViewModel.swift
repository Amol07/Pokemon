//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation
import Combine

/// ViewModel for managing and displaying a list of Pokémon.
class PokemonListViewModel: ObservableObject {
	/// An array of `Pokemon` objects representing the list of Pokémon fetched from the service.
	@Published var pokemonList = [Pokemon]()

	/// A boolean indicating whether data is currently being fetched.
	@Published var isLoading = false

	/// A boolean indicating whether the user is currently searching through the Pokémon list.
	@Published var isSearching = false

	/// A string to hold error messages when a network request fails.
	@Published var errorMessage: String?

	/// A string representing the current search text input by the user.
	@Published var searchText = ""

	/// A cancellable instance used to manage the Combine subscription.
	private var cancellable: AnyCancellable?

	/// An integer representing the total number of Pokémon available from the service.
	private var totalResults = 0

	/// An integer representing the current offset for pagination.
	private var offset = 0

	/// An integer representing the number of Pokémon to fetch per request.
	private let limit = 100

	/// An instance of `PokemonService` used to fetch data from the Pokémon API.
	let pokemonService: PokemonService

	/// Initializes a new instance of `PokemonListViewModel` with a default or provided `PokemonService`.
	/// - Parameter pokemonService: The service used to fetch Pokémon data.
	init(pokemonService: PokemonService = PokemonServiceImpl(networkManager: NetworkManager())) {
		self.pokemonService = pokemonService
		self.isLoading = true
	}

	/// Fetches a list of Pokémon from the service, updates the `pokemonList`, handles pagination, and manages the loading state.
	func fetchPokemonList() {
		isLoading = true
		cancellable = pokemonService.fetchPokemonList(limit: limit, offset: offset)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				self.isLoading = false
				if case .failure(let error) = completion {
					self.errorMessage = error.localizedDescription
				}
			}, receiveValue: { response in
				self.totalResults = response.count
				self.pokemonList.append(contentsOf: response.results ?? [])
				self.offset += self.limit
			})
	}

	/// Fetches more Pokémon by incrementing the offset and calling `fetchPokemonList()`.
	func loadMorePokemons() {
		fetchPokemonList()
	}

	/// Sorts the `pokemonList` alphabetically by Pokémon name.
	func sortByName() {
		pokemonList.sort { $0.name < $1.name }
	}

	/// Sorts the `pokemonList` by Pokémon ID.
	func sortById() {
		pokemonList.sort { $0.id < $1.id }
	}

	/// Determines if the "Show More" button should be displayed based on the current state.
	/// - Returns: `true` if there are more Pokémon to load and the view is not currently loading; otherwise, `false`.
	func shoudDisplayShowMore() -> Bool {
		return searchText.isEmpty && totalResults > pokemonList.count && !isLoading
	}

	/// Filters the `pokemonList` based on the `searchText`.
	/// - Returns: An array of `Pokemon` that matches the search criteria.
	func filteredPokemonList() -> [Pokemon] {
		if searchText.isEmpty {
			return pokemonList
		} else {
			return pokemonList.filter { $0.name.contains(searchText.lowercased()) }
		}
	}
}
