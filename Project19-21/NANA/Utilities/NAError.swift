//
//  NAError.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import Foundation

enum NAError: String, Error {
	
	case unableToSave = "Unable to save notes. Try again."
	case unableToLoad = "Unable to load saved notes. Try again."
}
