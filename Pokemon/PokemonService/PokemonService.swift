//
//  PokemonService.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation
import Combine

/// Protocol defining the Pokemon service.
protocol PokemonService {

	/// Fetches a list of Pokémon from the API.
	///
	/// - Parameters:
	///   - limit: The number of Pokémon to fetch.
	///   - offset: The offset for pagination.
	/// - Returns: A publisher that outputs a `PokemonResponse` or a `NetworkError`.
	func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<PokemonResponse, NetworkError>

	/// Fetches the details of a specific Pokémon from the API.
	///
	/// - Parameter url: The URL string for the Pokémon details.
	/// - Returns: A publisher that outputs a `PokemonDetail` or a `NetworkError`.
	func fetchPokemonDetail(url: String) -> AnyPublisher<PokemonDetail, NetworkError>
}

/// Implementation of the `PokemonService` protocol.
class PokemonServiceImpl: PokemonService {

	/// The network manager used to perform network requests.
	private let networkManager: NetworkService

	/// Initializes a new instance of `PokemonServiceImpl`.
	///
	/// - Parameter networkManager: An instance of `NetworkService` used for performing network requests.
	init(networkManager: NetworkService) {
		self.networkManager = networkManager
	}

	/// Fetches a list of Pokémon from the API.
	///
	/// - Parameters:
	///   - limit: The number of Pokémon to fetch.
	///   - offset: The offset for pagination.
	/// - Returns: A publisher that outputs a `PokemonResponse` or a `NetworkError`.
	func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<PokemonResponse, NetworkError> {
		let requestBuilder = PokemonListRequestBuilder(limit: limit, offset: offset)
		return networkManager.fetchData(with: requestBuilder)
	}

	/// Fetches the details of a specific Pokémon from the API.
	///
	/// - Parameter url: The URL string for the Pokémon details.
	/// - Returns: A publisher that outputs a `PokemonDetail` or a `NetworkError`.
	func fetchPokemonDetail(url: String) -> AnyPublisher<PokemonDetail, NetworkError> {
		let requestBuilder = PokemonDetailRequestBuilder(url: url)
		return networkManager.fetchData(with: requestBuilder)
	}
}
