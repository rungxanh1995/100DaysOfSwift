//
//  GameState.swift
//  Project5
//
//  Created by Joe Pham on 2021-03-02.
//

import Foundation

// Project 12, challenge 3
class GameState: NSObject, Codable {
	var currentWord: String
	var usedWords: [String]
	
	init(currentWord: String, usedWords: [String]) {
		self.currentWord = currentWord
		self.usedWords = usedWords
	}
}
