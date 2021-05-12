//
//  Picture.swift
//  PicAName
//
//  Created by Joe Pham on 2021-05-11.
//

import Foundation

class Picture: Codable {
	var imageName: String
	var caption: String
	
	init(imageName: String, caption: String) {
		self.imageName = imageName
		self.caption = caption
	}
}
