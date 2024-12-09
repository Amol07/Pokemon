//
//  MockNetworkManager.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import Combine
import Foundation
@testable import Pokemon

class MockNetworkManager: NetworkService {
	var fetchDataCallCount = 0
	var shouldReturnError = false

	func fetchData<T>(with requestBuilder: URLRequestBuilder) -> AnyPublisher<T, NetworkError> where T : Decodable {
		fetchDataCallCount += 1

		if shouldReturnError {
			return Fail(error: NetworkError.serverError(500))
				.eraseToAnyPublisher()
		}

		if T.self == PokemonResponse.self {
			let response = PokemonResponse(count: 1118, next: nil, previous: nil, results: [])
			return Just(response as! T)
				.setFailureType(to: NetworkError.self)
				.eraseToAnyPublisher()
		} else if T.self == PokemonDetail.self {
			let detail = PokemonDetail(fromFile: "PokemonDetail")
			return Just(detail as! T)
				.setFailureType(to: NetworkError.self)
				.eraseToAnyPublisher()
		}

		return Fail(error: NetworkError.unknown)
			.eraseToAnyPublisher()
	}
}
