//
//  Bundle+Ext.swift
//  Penguin-Ninja
//
//  Created by Joe Pham on 2021-08-03.
//

import Foundation

extension Bundle {
	
	/**
	Shortens the call to find a resource file in the app bundle
	provided you knew the name of the file and its extension.
	
	Best used with constants.
	
	- parameters:
		- fileNamed: The string for the file name
	*/
	
	func getPath(of fileNamed: String) -> URL? {
		if let path = Bundle.main.url(forResource: fileNamed, withExtension: nil) { return path }
		else { return nil }
	}
}
