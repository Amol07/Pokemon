//
//  PokemonDetailView.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import SwiftUI

struct PokemonDetailView: View {
	@StateObject var viewModel: PokemonDetailViewModel

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack {
				if let detail = viewModel.pokemonDetail, let name = detail.name {
					HStack(alignment: .center, spacing: 16) {
						Text(name.capitalized)
							.font(.largeTitle)
					}
					HStack(alignment: .center, spacing: 16) {
						Text("ID: \(detail.id)")
							.font(.headline)
						Text("|")
						Text("Height: \(detail.height)")
							.font(.headline)
						Text("|")
						Text("Weight: \(detail.weight)")
							.font(.headline)
					}

					Text("Base Experience: \(detail.baseExperience)")
					Text("Abilities: \(detail.abilities?.compactMap { $0.ability?.name?.capitalized }.joined(separator: ", ") ?? "Not Available")")

					LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 8, pinnedViews: [], content: {
						ForEach(detail.sprites?.allSprites ?? [], id: \.self) { url in
							AsyncCacheImageView(url: URL(string: url)!)
								.frame(minWidth: 100, minHeight: 100)
								.border(Color.gray, width: 1)

						}
					})
					.padding()
				} else if let errorMessage = viewModel.errorMessage {
					Text("Error: \(errorMessage)")
						.foregroundColor(.red)
				} else {
					Text("Loading...")
				}
				Spacer()
			}
			.task {
				viewModel.fetchPokemonDetail()
			}
		}
		.navigationTitle("Detail")
	}
}

#Preview{
	PokemonDetailView(viewModel: .init(pokemonService: PokemonServiceImpl(networkManager: NetworkManager()), 
									   pokemonURL: "https://pokeapi.co/api/v2/pokemon/1/"))
}
