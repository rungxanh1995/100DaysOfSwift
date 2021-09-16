//
//  SKScene+Ext.swift
//  Exploding Monkeys
//
//  Created by Joe Pham on 2021-09-15.
//

import SpriteKit.SKScene

extension SKScene {
	
	func removeFromParent(_ elements: SKNode...) {
		elements.forEach { $0.removeFromParent() }
	}
}
