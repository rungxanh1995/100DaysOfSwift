//
//  EnemyType.swift
//  Penguin-Ninja
//
//  Created by Joe Pham on 2021-08-02.
//

import Foundation


enum SequenceType: CaseIterable {
	case oneNoBomb
	case one
	case twoWithOneBomb
	case two
	case three
	case four
	case chain
	case fastChain
}

extension SequenceType {
	
	// set deliberate learning curve to let user get used to the game
	static let initialPattern: [SequenceType] = [.oneNoBomb, .oneNoBomb, .twoWithOneBomb, .twoWithOneBomb, .three, .one, .chain]
	
	// add more sequence with a given loop number
	static func generateRandomSequence(loops: Int) -> [SequenceType] {
		var sequence: [SequenceType] = []
		for _ in 0..<loops {
			if let nextSequence = SequenceType.allCases.randomElement() { sequence.append(nextSequence) }
		}
		return sequence
	}
}
