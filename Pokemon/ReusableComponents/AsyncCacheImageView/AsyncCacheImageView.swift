//
//  AsyncCacheImageView.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import SwiftUI

/// Singleton class for caching images.
class ImageCache {
	/// Shared instance of the `ImageCache`.
	static let shared = ImageCache()

	/// Private initializer to ensure singleton instance.
	private init() {}

	/// Dictionary to store cached images with their corresponding URLs.
	private var cache: [URL: UIImage] = [:]

	/// Retrieves an image from the cache for a given URL.
	///
	/// - Parameter url: The URL of the image.
	/// - Returns: The cached image if it exists, otherwise `nil`.
	func getImage(for url: URL) -> UIImage? {
		return cache[url]
	}

	/// Saves an image to the cache for a given URL.
	///
	/// - Parameters:
	///   - image: The image to cache.
	///   - url: The URL of the image.
	func saveImage(_ image: UIImage, for url: URL) {
		cache[url] = image
	}
}

/// View for asynchronously loading and displaying an image from a URL with caching.
struct AsyncCacheImageView: View {
	/// The URL of the image to load.
	private let url: URL

	/// The image loader responsible for loading the image.
	@StateObject private var loader: ImageLoader

	/// Initializes a new instance of `AsyncCacheImageView`.
	///
	/// - Parameter url: The URL of the image to load.
	init(url: URL) {
		self.url = url
		_loader = StateObject(wrappedValue: ImageLoader(url: url))
	}

	/// The body of the view.
	var body: some View {
		if let image = loader.image {
			Image(uiImage: image)
				.resizable()
				.aspectRatio(contentMode: .fit)
		} else {
			ProgressView()
		}
	}
}
