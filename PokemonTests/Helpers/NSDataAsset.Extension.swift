//
//  NSDataAsset.swift
//  PokemonTests
//
//  Created by Amol Prakash on 27/05/24.
//

import UIKit

extension NSDataAsset {

	static func getFromFile<Model: Decodable>(withName fileName: String, bundle: Bundle = .testBundle) -> Model {
		guard let data = NSDataAsset(name: fileName, bundle: bundle)?.data else {
			fatalError("Data asset with name \"\(fileName)\" not found.")
		}

		do {
			return try JSONDecoder().decode(Model.self, from: data)
		} catch let error as DecodingError {
			fatalError("Data asset with name \"\(fileName)\" cannot be decoded, Error: \n \(error.printDescription())")
		} catch {
			fatalError("Data asset with name \"\(fileName)\" cannot be decoded, Error: \n \(error.localizedDescription)")
		}
	}
}
