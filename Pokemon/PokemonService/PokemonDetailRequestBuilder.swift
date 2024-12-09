//
//  PokemonDetailRequestBuilder.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation

/// Builder for constructing a Pokémon detail request.
struct PokemonDetailRequestBuilder: URLRequestBuilder {
	var baseURL: String
	var path: String? { nil }
	var method: HTTPMethod { .get }
	var headers: [String: String]? { nil }
	var queryParams: [String: String]? { nil }
	var bodyParams: [String: Any]? { nil }

	/// Initializes a new instance of `PokemonDetailRequestBuilder` with the provided URL.
	/// - Parameter url: The URL string for the Pokémon details.
	init(url: String) {
		self.baseURL = url
	}
}
