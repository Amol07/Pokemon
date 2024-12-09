//
//  NetworkError.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation

/// Enum representing the possible network errors.
enum NetworkError: Error, Equatable {
	/// Indicates an invalid URL error.
	case invalidURL
	/// Indicates a request failure with an associated error.
	case requestFailed(Error)
	/// Indicates a decoding failure with an associated error.
	case decodingFailed(Error)
	/// Indicates a server error with an associated status code.
	case serverError(Int)
	/// Indicates an unknown error.
	case unknown

	/// Equatable conformance for `NetworkError`.
	static func ==(lhs: NetworkError, rhs: NetworkError) -> Bool {
		switch (lhs, rhs) {
			case (.invalidURL, .invalidURL):
				return true
			case (.requestFailed(let lhsError), .requestFailed(let rhsError)):
				return lhsError.localizedDescription == rhsError.localizedDescription
			case (.decodingFailed(let lhsError), .decodingFailed(let rhsError)):
				return lhsError.localizedDescription == rhsError.localizedDescription
			case (.serverError(let lhsCode), .serverError(let rhsCode)):
				return lhsCode == rhsCode
			case (.unknown, .unknown):
				return true
			default:
				return false
		}
	}
}
