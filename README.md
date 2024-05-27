# Pokemon
This project is a Pokémon app built using SwiftUI. The app fetches a list of Pokémon from the Pokémon API and displays details about each Pokémon when selected. The app is designed to be modular, reusable, testable, and includes various advanced features like pagination, sorting, searching and image caching.

## Features

- Pokémon List and Details
	- Display a list of Pokémon.
	- Show detailed information about a selected Pokémon.
	
- Network Layer
	- A separate, reusable network layer with error handling.
	- Testable using mock URL sessions.
	
- Services
	- Service classes to fetch Pokémon list and details.
	- Dependency injection for easy testing.

- View Models
	- View models for both list and detail views.
	- Segregated logic to ensure testability.
	
- Pagination
	- Fetch more Pokémon as the user scrolls.
	
- Sorting and Searching
	- Sort the Pokémon list by name or ID.
	- Search functionality to filter the list.
	
- Image Caching
	- Reusable image caching component.
	
## Project Structure

```
├── Network
│   ├── NetworkManager.swift
│   ├── MockURLSession.swift
│
├── Services
│   ├── PokemonService.swift
│   ├── PokemonServiceImpl.swift
│
├── ViewModels
│   ├── PokemonListViewModel.swift
│   ├── PokemonDetailViewModel.swift
│
├── Views
│   ├── PokemonListView.swift
│   ├── PokemonDetailView.swift
│
├── Models
│   ├── PokemonResponse.swift
│   ├── Pokemon.swift
│   ├── PokemonDetail.swift
│
├── Utilities
│   ├── AsyncCacheImageView.swift
│
├── Tests
│   ├── NetworkManagerTests.swift
│   ├── PokemonServiceImplTests.swift
│   ├── PokemonListViewModelTests.swift
│   ├── PokemonDetailViewModelTests.swift
```

## Usage

### Fetch Pokémon List
The `PokemonListViewModel` is responsible for fetching the list of Pokémon using the `PokemonService`.

### Fetch Pokémon Details
The `PokemonDetailViewModel` fetches detailed information about a selected Pokémon using the `PokemonService`.

### Pagination
The Pokémon list view supports pagination to load more Pokémon as the user scrolls.

### Sorting and Searching
The Pokémon list can be sorted by name or ID, and the search functionality allows filtering the Pokémon list.

### Image Caching
The `AsyncCacheImageView` is a reusable component for asynchronous image loading with caching.

## Unit Tests

The project includes unit tests for:

- `NetworkManager`
- `PokemonServiceImpl`
- `PokemonListViewModel`
- `PokemonDetailViewModel`

Test cases are located in the Tests directory.
