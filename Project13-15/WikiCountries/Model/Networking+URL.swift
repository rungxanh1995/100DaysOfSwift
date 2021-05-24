//
//  Networking+URL.swift
//  WikiCountries
//
//  Created by Joe Pham on 2021-05-24.
//

import Foundation

extension Bundle {
	func decode<T: Decodable>(from urlString: String) -> T {
		guard let url = URL(string: urlString) else {
			fatalError("Unable to decode URL from \(urlString)")
		}
		guard let data = try? Data(contentsOf: url) else {
			fatalError("Failed to load data from \(urlString)")
		}
		guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
			fatalError("Failed to decode data from \(urlString)")
		}
		return decoded
	}
}
