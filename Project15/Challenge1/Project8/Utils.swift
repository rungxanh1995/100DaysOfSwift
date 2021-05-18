//
//  Utils.swift
//  Project8
//
//  Created by Joe Pham on 2021-05-17.
//

import Foundation

struct AlertItem {
	var title: String
	var message: String
	var buttonTitle: String
}

struct AlertContext {
	static let nextLevelAlert = AlertItem(title: "Well done!",
										  message: "Are you ready for the next level?",
										  buttonTitle: "Let's go!")
	static let wrongWordAlert = AlertItem(title: "Oops",
										  message: "Your invented word exceeded our expectation!",
										  buttonTitle: "Try again")
}
