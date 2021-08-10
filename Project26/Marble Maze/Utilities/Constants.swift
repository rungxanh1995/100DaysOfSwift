//
//  Constants.swift
//  Marble Maze
//
//  Created by Joe Pham on 2021-08-09.
//

import SpriteKit


enum Asset {
	enum Names {
		static let background		= "background"
		static let ball				= "marble"
		static let block			= "block"
		static let vortex			= "vortex"
		static let portal			= "portal"
		static let star				= "star"
		static let finish			= "finish"
	}
}


enum Symbols {
	static let space: Character		= " "
	static let wall: Character		= "x"
	static let vortex: Character	= "v"
	static let portal: Character	= "p"
	static let star: Character		= "s"
	static let finish: Character	= "f"
}


enum CollisionTypes: UInt32 {
	case none						= 0
	case ball						= 1
	case wall						= 2
	case star						= 4
	case vortex						= 8
	case finish						= 16
	case portal						= 32
}


enum Display {
	static let width 				= UIScreen.main.bounds.width
	static let height 				= UIScreen.main.bounds.height
	static let leftEdge				= CGFloat(0)
	static let rightEdge			= width
	static let bottomEdge			= CGFloat(0)
	static let topEdge				= height
	
	static let xGridLine1			= width * 1/4
	static let xGridLine2			= width * 2/4
	static let xGridLine3			= width * 3/4
	static let xGridLine4			= width * 4/4
	
	static let yGridLine1			= height * 1/3
	static let yGridLine2			= height * 2/3
	static let yGridLine3			= height * 3/3
}


