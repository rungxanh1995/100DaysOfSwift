//
//  SKNode+Ext.swift
//  Marble Maze
//
//  Created by Joe Pham on 2021-08-09.
//

import SpriteKit

extension SKNode {
	
	func rorateForever() {
		let rotate			= SKAction.rotate(byAngle: .pi, duration: 1.0)
		self.run(SKAction.repeatForever(rotate))
	}
	
	
	func rotateWithPulse() {
		let scaleDown		= SKAction.scale(to: 0.75, duration: 0.5)
		let enlarge			= SKAction.scale(to: 1.1, duration: 0.5)
		let pulse			= SKAction.sequence([scaleDown, enlarge, scaleDown, enlarge])
		let rotate			= SKAction.rotate(byAngle: .pi, duration: 2.0)
		let group			= SKAction.group([pulse, rotate])
		self.run(SKAction.repeatForever(group))
	}
	
	
	func wiggleForever(leftAndRight: Bool = false) {
		
		switch leftAndRight {
		
		case true:
			let rotRight	= SKAction.rotate(byAngle: 0.15, duration: 0.25)
			let rotLeft		= SKAction.rotate(byAngle: -0.15, duration: 0.25)
			let cycle		= SKAction.sequence([rotRight, rotLeft, rotLeft, rotRight])
			let wiggle		= SKAction.repeatForever(cycle)
			self.run(wiggle)
			
		case false:
			let wiggleIn	= SKAction.scaleX(to: 0.9, duration: 0.25)
			let wiggleOut	= SKAction.scaleX(to: 1.1, duration: 0.25)
			let wiggle		= SKAction.sequence([wiggleIn, wiggleOut])
			self.run(SKAction.repeatForever(wiggle))
		}
	}
	
	
	func suckedInto(_ node: SKNode, completed: (() -> Void)? = nil) {
		let move			= SKAction.move(to: node.position, duration: 0.25)
		let scale			= SKAction.scale(to: 0.0001, duration: 0.25)
		let remove			= SKAction.removeFromParent()
		let sequence		= SKAction.sequence([move, scale, remove])
		self.run(sequence)
	}
	
	
	func pulsateThenGone() {
		let fadeOut			= SKAction.fadeOut(withDuration: 0.25)
		let enlarge			= SKAction.scale(to: 2, duration: 0.25)
		let remove			= SKAction.removeFromParent()
		let sequence		= SKAction.sequence([SKAction.group([fadeOut, enlarge]), remove])
		self.run(sequence)
	}
}
