//
//  Constants.swift
//  JavaScript Injection
//
//  Created by Joe Pham on 2021-07-15.
//

import UIKit


enum SFSymbols {
	static let text		= UIImage(systemName: "text.justifyleft")
}


struct Alert {
	let title: String
	let message: String?
}


enum AlertContext {
	static let examples	= Alert(title: "Examples", message: "Choose a pre-written code snippet")
	static let cancel	= Alert(title: "Cancel", message: nil)
}
