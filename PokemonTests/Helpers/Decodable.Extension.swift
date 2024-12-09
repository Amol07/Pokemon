//
//  Decodable.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import UIKit

extension Decodable {

	init(fromFile fileName: String, bundle: Bundle = .testBundle) {
		self = NSDataAsset.getFromFile(withName: fileName, bundle: bundle)
	}

	init?(withData data: Data) {
		do {
			self = try JSONDecoder().decode(Self.self, from: data)
		} catch let error as DecodingError {
			fatalError("Data asset with type \"\(Self.self)\" cannot be decoded, Error: \n \(error.printDescription())")
		} catch {
			fatalError("Data asset with type \"\(Self.self)\" cannot be decoded, Error: \n \(error.localizedDescription)")
		}
	}

	init?(withJSONString string: String) {
		self.init(withData: Data(string.utf8))
	}
}
