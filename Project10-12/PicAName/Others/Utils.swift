//
//  Utils.swift
//  PicAName
//
//  Created by Joe Pham on 2021-05-11.
//

import Foundation

class Utils {
	static let picturesKey = "Pictures"
	
	static func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	static func getImageURL(for imageName: String) -> URL {
		return getDocumentsDirectory().appendingPathComponent(imageName)
	}
	
	static func savePictures(pictures: [Picture]) {
		if let encodedPictures = try? JSONEncoder().encode(pictures) {
			UserDefaults.standard.set(encodedPictures, forKey: picturesKey)
		}
	}
	
	static func loadPictures() -> [Picture] {
		if let loadedPictures = UserDefaults.standard.object(forKey: picturesKey) as? Data {
			if let decodedPictures = try? JSONDecoder().decode([Picture].self, from: loadedPictures) {
				return decodedPictures
			}
		}
		return [Picture]()
	}
}
