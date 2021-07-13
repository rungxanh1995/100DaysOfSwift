//
//  Constants.swift
//  Space Race
//
//  Created by Joe Pham on 2021-07-13.
//

import SpriteKit


enum Debris {
	static let ball			= "ball"
	static let hammer		= "hammer"
	static let tv			= "tv"
}


enum EmitterNodes {
	static let starfield	= SKEmitterNode(fileNamed: "starfield")!
	static let explosion	= SKEmitterNode(fileNamed: "explosion")!
}


enum SpriteNodes {
	static let player		= SKSpriteNode(imageNamed: "player")
	static let spark 		= SKSpriteNode(imageNamed: "spark")
}


enum LabelNodes {
	static let score		= SKLabelNode(fontNamed: "Chalkduster")
}


enum Display {
	static let width 		= UIScreen.main.bounds.width
	static let height 		= UIScreen.main.bounds.height
	static let leftBound	= CGFloat(0)
	static let bottomBound	= CGFloat(0)
}
