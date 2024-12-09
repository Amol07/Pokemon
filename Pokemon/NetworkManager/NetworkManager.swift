//
//  NetworkManager.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Combine
import Foundation

/// Protocol defining a network service for fetching data.
protocol NetworkService {

	/// Fetches data from the network based on the provided request builder.
	/// - Parameter requestBuilder: An instance conforming to `URLRequestBuilder`.
	/// - Returns: A publisher that outputs decoded data or a `NetworkError`.
	func fetchData<T: Decodable>(with requestBuilder: URLRequestBuilder) -> AnyPublisher<T, NetworkError>
}

/// Class implementing the `NetworkService` protocol.
class NetworkManager: NetworkService {

	func fetchData<T: Decodable>(with requestBuilder: URLRequestBuilder) -> AnyPublisher<T, NetworkError> {
		do {
			let request = try requestBuilder.buildRequest()
			return URLSession.shared.dataTaskPublisher(for: request)
				.tryMap { data, response -> Data in
					if let httpResponse = response as? HTTPURLResponse,
					   !(200...299).contains(httpResponse.statusCode) {
						throw NetworkError.serverError(httpResponse.statusCode)
					}
					return data
				}
				.mapError { error -> NetworkError in
					if let networkError = error as? NetworkError {
						return networkError
					} else if let urlError = error as? URLError {
						return NetworkError.requestFailed(urlError)
					} else {
						return NetworkError.unknown
					}
				}
				.decode(type: T.self, decoder: JSONDecoder())
				.mapError { error -> NetworkError in
					NetworkError.decodingFailed(error)
				}
				.eraseToAnyPublisher()
		} catch {
			return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
		}
	}
}
