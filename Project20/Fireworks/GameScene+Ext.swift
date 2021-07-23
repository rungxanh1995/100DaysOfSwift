//
//  GameScene+Ext.swift
//  Fireworks
//
//  Created by Joe Pham on 2021-07-20.
//

import SpriteKit


extension GameScene {
	
	func configureGameBackground() {
		let background			= SKSpriteNode(imageNamed: NodeNames.background)
		background.position		= CGPoint(x: Display.width / 2, y: Display.height / 2)
		background.blendMode	= .replace
		background.zPosition	= -1
		addChild(background)
	}
	
	func configureGameTimer() {
		gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
	}
	
	
	// challenge 1
	func configureScoreLabel() {
		scoreLabel				= SKLabelNode(fontNamed: FontNames.chalkduster)
		scoreLabel.position		= CGPoint(x: Display.leftEdge + 16, y: Display.bottomEdge + 16)
		scoreLabel.name			= "Score label"
		scoreLabel.horizontalAlignmentMode	= .left
		addChild(scoreLabel)
	}
	
	
	// challenge 2
	func configureGameOverLabel() {
		gameOverLabel			= SKLabelNode(fontNamed: FontNames.chalkduster)
		gameOverLabel.position	= CGPoint(x: Display.width / 2, y: Display.height / 2)
		gameOverLabel.zPosition = 999
		gameOverLabel.fontSize	= 48
		gameOverLabel.text		= "GAME OVER"
		gameOverLabel.name		= "Game Over label"
		gameOverLabel.horizontalAlignmentMode	= .center
		addChild(gameOverLabel)
	}
	
	
	@objc
	private func launchFireworks() {
		// challenge 2
		guard launchCount < maxLaunches else {
			configureGameOverLabel()
			gameTimer?.invalidate()
			return
		}
		
		let movementAmount: CGFloat = 1800
		
		switch Int.random(in: 0...3) {
		case 0:
			// fire five, straight up
			createFirework(xMovement: 0, x: Display.width / 2, y: bottomEdge)
			createFirework(xMovement: 0, x: Display.width / 2 - 200, y: bottomEdge)
			createFirework(xMovement: 0, x: Display.width / 2 - 100, y: bottomEdge)
			createFirework(xMovement: 0, x: Display.width / 2 + 100, y: bottomEdge)
			createFirework(xMovement: 0, x: Display.width / 2 + 200, y: bottomEdge)
			
		case 1:
			// fire five, in a fan
			createFirework(xMovement: 0, x: Display.width / 2, y: bottomEdge)
			createFirework(xMovement: -200, x: Display.width / 2 - 200, y: bottomEdge)
			createFirework(xMovement: -100, x: Display.width / 2 - 100, y: bottomEdge)
			createFirework(xMovement: 100, x: Display.width / 2 + 100, y: bottomEdge)
			createFirework(xMovement: 200, x: Display.width / 2 + 200, y: bottomEdge)
			
		case 2:
			// fire five, from the left to the right
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
			createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)
			
		case 3:
			// fire five, from the right to the left
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
			createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)
			
		default:
			break
		}
		
		launchCount += 1 // challenge 2
	}
	
	
	private func createFirework(xMovement: CGFloat, x: CGFloat, y: CGFloat) {
		// 1
		let fireworkNode			= SKNode()
		fireworkNode.position		= CGPoint(x: x, y: y)
		
		// 2 + 3
		let firework				= SKSpriteNode(imageNamed: NodeNames.firework)
		firework.name				= NodeNames.firework
		firework.colorBlendFactor	= 1
		fireworkNode.addChild(firework)
		
		switch Int.random(in: 0...2) {
		case 0: 	firework.color = .cyan
		case 1: 	firework.color = .green
		case 2: 	firework.color = .red
		default: 	break
		}
		
		// 4 + 5
		let path = UIBezierPath()
		path.move(to: .zero)
		path.addLine(to: CGPoint(x: xMovement, y: Display.height + 300))
		
		let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
		fireworkNode.run(move)
		
		// 6
		if let emitter = SKEmitterNode(fileNamed: NodeNames.fuse) {
			emitter.position = CGPoint(x: 0, y: -22)
			fireworkNode.addChild(emitter)
		}
		
		// 7
		addChild(fireworkNode)
		fireworks.append(fireworkNode)
	}
	
	
	func removeFireworksWhenOffScreen() {
		for (i, firework) in fireworks.enumerated().reversed() {
			if firework.position.y > Display.topEdge + 200 {
				firework.removeFromParent()
				fireworks.remove(at: i)
			}
		}
	}
	
	
	func explode(node firework: SKNode) {
		let explosion		= SKEmitterNode(fileNamed: NodeNames.explode)!
		explosion.position	= firework.position
		addChild(explosion)
		
		removeNodeAfterDuration(node: firework, duration: 0.0)
		removeNodeAfterDuration(node: explosion, duration: 2.0) // challenge 3
	}
	
	
	// challenge 3
	private func removeNodeAfterDuration(node: SKNode, duration: TimeInterval) {
		let wait 		= SKAction.wait(forDuration: duration)
		let removal		= SKAction.run { node.removeFromParent() }
		let sequence	= SKAction.sequence([wait, removal])
		node.run(sequence)
	}
}
