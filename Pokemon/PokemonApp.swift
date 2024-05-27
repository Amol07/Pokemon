//
//  PokemonApp.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import SwiftUI

@main
struct PokemonApp: App {

    var body: some Scene {
        WindowGroup {
			PokemonListView(
				viewModel: .init(pokemonService: PokemonServiceImpl(networkManager: NetworkManager()))
			)
        }
    }
}
