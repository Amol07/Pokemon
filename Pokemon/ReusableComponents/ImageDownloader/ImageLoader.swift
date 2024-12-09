//
//  ImageLoader.swift
//  Pokemon
//
//  Created by Amol Prakash on 27/05/24.
//

import SwiftUI

/// Class responsible for asynchronously loading an image from a URL.
class ImageLoader: ObservableObject {
	/// The published property to store the loaded image.
	@Published var image: UIImage?

	/// The URL of the image to load.
	private let url: URL

	/// Initializes a new instance of `ImageLoader`.
	///
	/// - Parameter url: The URL of the image to load.
	init(url: URL) {
		self.url = url
		loadImage()
	}

	/// Loads the image from the URL, using the cache if available.
	private func loadImage() {
		// Check if the image is already cached
		if let cachedImage = ImageCache.shared.getImage(for: url) {
			self.image = cachedImage
			return
		}

		// Download the image from the URL
		URLSession.shared.dataTask(with: url) { data, _, _ in
			// Check if data is received and convert it to UIImage
			if let data = data, let image = UIImage(data: data) {
				DispatchQueue.main.async {
					// Save the image to cache and update the published property
					ImageCache.shared.saveImage(image, for: self.url)
					self.image = image
				}
			}
		}.resume()
	}
}
