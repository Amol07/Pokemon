//
//  PokemonResponse.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation

// MARK: - PokemonResponse
struct PokemonResponse: Codable {
	let count: Int
	let next, previous: String?
	let results: [Pokemon]?
}

// MARK: - Pokemon
/// A model representing a Pokémon.
struct Pokemon: Codable, Identifiable {
	/// The name of the Pokémon.
	let name: String

	/// The URL containing more details about the Pokémon.
	let url: String

	/// The unique identifier of the Pokémon, extracted from the URL.
	let id: Int

	/// Coding keys to map the JSON keys to the struct properties.
	enum CodingKeys: String, CodingKey {
		case name, url
	}

	/// Custom initializer to decode and extract the ID from the URL.
	/// - Parameter decoder: The decoder to read data from.
	/// - Throws: A `DecodingError` if the URL does not contain a valid ID.
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		// Decode the name and url from the JSON
		name = try container.decode(String.self, forKey: .name)
		url = try container.decode(String.self, forKey: .url)

		// Extract the ID from the URL
		if let idString = url.split(separator: "/").last, let id = Int(idString) {
			self.id = id
		} else {
			throw DecodingError.dataCorruptedError(forKey: .url, in: container, debugDescription: "URL does not contain a valid ID")
		}
	}

	/// Initializer to create a `Pokemon` instance directly.
	/// - Parameters:
	///   - name: The name of the Pokémon.
	///   - url: The URL containing more details about the Pokémon.
	///   - id: The unique identifier of the Pokémon.
	init(name: String, url: String, id: Int) {
		self.name = name
		self.url = url
		self.id = id
	}
}
