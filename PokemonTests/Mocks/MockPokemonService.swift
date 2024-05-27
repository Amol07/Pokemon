//
//  MockPokemonService.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import Combine
import Foundation
@testable import Pokemon

class MockPokemonService: PokemonService {
	var shouldReturnError = false

	func fetchPokemonList(limit: Int, offset: Int) -> AnyPublisher<PokemonResponse, NetworkError> {
		if shouldReturnError {
			return Fail(error: NetworkError.serverError(500))
				.eraseToAnyPublisher()
		} else {
			let response = PokemonResponse(fromFile: "PokemonList")
			return Just(response)
				.setFailureType(to: NetworkError.self)
				.eraseToAnyPublisher()
		}
	}

	func fetchPokemonDetail(url: String) -> AnyPublisher<PokemonDetail, NetworkError> {
		if shouldReturnError {
			return Fail(error: NetworkError.serverError(500))
				.eraseToAnyPublisher()
		} else {
			let detail = PokemonDetail(fromFile: "PokemonDetail")
			return Just(detail)
				.setFailureType(to: NetworkError.self)
				.eraseToAnyPublisher()
		}
	}
}
