//
//  Constants.swift
//  Fireworks
//
//  Created by Joe Pham on 2021-07-18.
//

import SpriteKit


enum Display {
	static let width 		= UIScreen.main.bounds.width
	static let height 		= UIScreen.main.bounds.height
	static let leftEdge		= CGFloat(0)
	static let rightEdge	= CGFloat(width)
	static let bottomEdge	= CGFloat(0)
	static let topEdge		= CGFloat(height)
}


enum GameScreenEdges {
	static let left			= Display.leftEdge - 22
	static let bottom		= Display.bottomEdge - 22
	static let right		= Display.rightEdge + 22
}


enum NodeNames {
	static let background	= "background"
	static let firework		= "firework"
	static let selected		= "selected"
	static let explode		= "explode"
	static let fuse			= "fuse"
}


enum FontNames {
	static let chalkduster	= "Chalkduster"
}
