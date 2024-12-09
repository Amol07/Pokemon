//
//  Bundle.Extension.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import Foundation

extension Bundle {
	static var testBundle: Bundle {
		Bundle(for: PokemonTests.self)
	}
}
