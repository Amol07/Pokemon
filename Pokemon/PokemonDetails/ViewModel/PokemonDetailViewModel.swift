//
//  PokemonDetailViewModel.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Combine
import SwiftUI

import Combine
import SwiftUI

/// ViewModel for managing and displaying details of a specific Pokémon.
class PokemonDetailViewModel: ObservableObject {
	/// The detailed information of the Pokémon.
	@Published var pokemonDetail: PokemonDetail?

	/// A string to hold error messages when a network request fails.
	@Published var errorMessage: String?

	/// A cancellable instance used to manage the Combine subscription.
	private var cancellable: AnyCancellable?

	/// The service used to fetch Pokémon data.
	private let pokemonService: PokemonService

	/// The URL string for the Pokémon details.
	private let pokemonURL: String

	/// Initializes a new instance of `PokemonDetailViewModel` with the provided `PokemonService` and Pokémon URL.
	/// - Parameters:
	///   - pokemonService: The service used to fetch Pokémon data.
	///   - pokemonURL: The URL string for the Pokémon details.
	init(pokemonService: PokemonService, pokemonURL: String) {
		self.pokemonService = pokemonService
		self.pokemonURL = pokemonURL
		fetchPokemonDetail()
	}

	/// Fetches the details of a specific Pokémon from the service and updates the `pokemonDetail` property.
	/// If the request fails, updates the `errorMessage` property with the error message.
	func fetchPokemonDetail() {
		cancellable = pokemonService.fetchPokemonDetail(url: pokemonURL)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { completion in
				if case .failure(let error) = completion {
					self.errorMessage = error.localizedDescription
				}
			}, receiveValue: { detail in
				self.pokemonDetail = detail
			})
	}
}
