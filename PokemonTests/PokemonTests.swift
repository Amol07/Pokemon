//
//  File.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import XCTest
@testable import Pokemon

class PokemonTests: XCTestCase {

	func testPokemonDecoding() throws {
		let json = """
  {
   "name": "bulbasaur",
   "url": "https://pokeapi.co/api/v2/pokemon/1/"
  }
  """.data(using: .utf8)!

		let decoder = JSONDecoder()
		let pokemon = try decoder.decode(Pokemon.self, from: json)

		XCTAssertEqual(pokemon.name, "bulbasaur")
		XCTAssertEqual(pokemon.url, "https://pokeapi.co/api/v2/pokemon/1/")
		XCTAssertEqual(pokemon.id, 1)
	}

	func testPokemonResponseDecoding() throws {
		let json = """
  {
   "count": 1118,
   "next": "https://pokeapi.co/api/v2/pokemon?offset=100&limit=100",
   "previous": null,
   "results": [
  {
  "name": "bulbasaur",
  "url": "https://pokeapi.co/api/v2/pokemon/1/"
  }
   ]
  }
  """.data(using: .utf8)!

		let decoder = JSONDecoder()
		let response = try decoder.decode(PokemonResponse.self, from: json)

		XCTAssertEqual(response.count, 1118)
		XCTAssertEqual(response.next, "https://pokeapi.co/api/v2/pokemon?offset=100&limit=100")
		XCTAssertNil(response.previous)
		XCTAssertEqual(response.results?.count, 1)
		XCTAssertEqual(response.results?.first?.name, "bulbasaur")
	}
}
