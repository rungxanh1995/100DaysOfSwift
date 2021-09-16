//
//  SKAction+Ext.swift
//  Exploding Monkeys
//
//  Created by Joe Pham on 2021-09-06.
//

import SpriteKit.SKNode

extension SKNode {
	
	func animateThrow(arm: ArmTypes, node: SKNode, handler: @escaping () -> Void) {
		
		var raiseArm: SKAction
		switch arm {
		case .left:
			raiseArm	= SKAction.setTexture(SKTexture(imageNamed: "player1Throw"))
			
		case .right:
			raiseArm	= SKAction.setTexture(SKTexture(imageNamed: "player2Throw"))
		}
		
		let lowerArm	= SKAction.setTexture(SKTexture(imageNamed: "player"))
		let pause		= SKAction.wait(forDuration: 0.15)
		let sequence	= SKAction.sequence([raiseArm, pause, lowerArm])
		node.run(sequence)
		
		handler()
	}
}

