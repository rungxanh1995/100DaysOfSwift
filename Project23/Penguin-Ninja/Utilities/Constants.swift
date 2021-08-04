//
//  Constants.swift
//  Penguin-Ninja
//
//  Created by Joe Pham on 2021-07-31.
//

import SpriteKit

enum Display {
	static let width 			= UIScreen.main.bounds.width
	static let height 			= UIScreen.main.bounds.height
	static let leftEdge			= CGFloat(0)
	static let rightEdge		= width
	static let bottomEdge		= CGFloat(0)
	static let topEdge			= height
	
	static let xGridLine1		= width * 1/4
	static let xGridLine2		= width * 2/4
	static let xGridLine3		= width * 3/4
	static let xGridLine4		= width * 4/4
	
	static let yGridLine1		= height * 1/3
	static let yGridLine2		= height * 2/3
	static let yGridLine3		= height * 3/3
}


enum Asset {
	static let penguin			= "penguin"
	static let background		= "sliceBackground"
	static let bombContainer	= "bombContainer"
	static let bomb				= "sliceBomb"
	static let life				= "sliceLife"
	
	static let sliceFuse		= "sliceFuse"
	static let sliceHitBomb 	= "sliceHitBomb"
	static let sliceHitEnemy	= "sliceHitEnemy"
	
	static let swoosh1			= "swoosh1.caf"
	static let swoosh2			= "swoosh2.caf"
	static let swoosh3			= "swoosh3.caf"
	static let launch			= "launch.caf"
	static let bombFuse			= "sliceBombFuse.caf"
}


enum LabelNode {
	static let score			= SKLabelNode(fontNamed: "Chalkduster")
}


enum TouchPoint {
	static let minimum			= 2
	static let maximum			= 12
}


