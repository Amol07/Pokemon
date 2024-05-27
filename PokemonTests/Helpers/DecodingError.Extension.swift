//
//  DecodingError.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation

extension DecodingError {
	func printDescription() {
		switch self {
			case .dataCorrupted(let context):
				debugPrint(context.debugDescription)
			case .keyNotFound(let key, let context):
				debugPrint("\(key.stringValue) was not found at codingPath:", context.codingPath, "context: \(context.debugDescription)")
			case .typeMismatch(let type, let context):
				debugPrint("\(type) was expected, \(context.debugDescription), codingPath:, \(context.codingPath)")
			case .valueNotFound(let type, let context):
				debugPrint("no value was found for \(type), \(context.debugDescription), codingPath:, \(context.codingPath)")
			default:
				debugPrint(self.localizedDescription)
		}
	}
}
