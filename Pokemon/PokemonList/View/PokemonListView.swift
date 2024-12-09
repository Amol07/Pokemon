//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import SwiftUI

struct PokemonListView: View {
	@StateObject var viewModel: PokemonListViewModel

	var body: some View {
		NavigationView {
			VStack {
				TextField("Search", text: $viewModel.searchText)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.padding()
				HStack {
					Button(action: {
						viewModel.sortByName()
					}) {
						Text("Sort by Name")
					}
					.frame(maxWidth: .infinity)

					Button(action: {
						viewModel.sortById()
					}) {
						Text("Sort by ID")
					}
					.frame(maxWidth: .infinity)
				}
				List {
					ForEach(viewModel.filteredPokemonList()) { pokemon in
						NavigationLink(destination: PokemonDetailView(viewModel: PokemonDetailViewModel(pokemonService: viewModel.pokemonService, pokemonURL: pokemon.url))) {
							Text(pokemon.name.capitalized)
						}
					}

					if viewModel.isLoading {
						HStack {
							Spacer()
							ProgressView()
							Spacer()
						}
					} else if viewModel.shoudDisplayShowMore()  {
						HStack {
							Spacer()
							Text("Loading...")
								.onAppear {
									viewModel.loadMorePokemons()
								}
							Spacer()
						}
					}
				}
				.scrollDismissesKeyboard(.immediately)
			}
			.navigationTitle("Pokémon")
		}
		.task {
			viewModel.fetchPokemonList()
		}
	}
}


#Preview {
	PokemonListView(viewModel: .init())
}
