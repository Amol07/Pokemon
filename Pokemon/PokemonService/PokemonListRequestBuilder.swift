//
//  PokemonListRequestBuilder.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation

/// Builder for constructing a Pokémon list request.
struct PokemonListRequestBuilder: URLRequestBuilder {
	var baseURL: String { "https://pokeapi.co/api/v2" }
	var path: String? { "/pokemon" }
	var method: HTTPMethod { .get }
	var headers: [String: String]? { nil }
	var queryParams: [String: String]?
	var bodyParams: [String: Any]? { nil }

	/// Initializes a new instance of `PokemonListRequestBuilder` with the provided limit and offset.
	/// - Parameters:
	///   - limit: The number of Pokémon to fetch.
	///   - offset: The offset for pagination.
	init(limit: Int, offset: Int) {
		self.queryParams = ["limit": "\(limit)", "offset": "\(offset)"]
	}
}
