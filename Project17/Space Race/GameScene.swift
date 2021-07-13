//
//  GameScene.swift
//  Space Race
//
//  Created by Joe Pham on 2021-07-13.
//

import SpriteKit

class GameScene: SKScene {
	
	private var starfield: SKEmitterNode!
	private var player: SKSpriteNode!
	
	private var scoreLabel: SKLabelNode!
	private var score = 0 {
		didSet { scoreLabel.text = "Score: \(score)"}
	}
    
	private let debris = [Debris.ball, Debris.hammer, Debris.tv]
	private var debrisBlockCount = 0 // challenge 2
	private var isGameOver = false
	
	private var gameTimer: Timer?
	private var timerInterval = 1.0 // challenge 2
	
	
	override func didMove(to view: SKView) {
		backgroundColor = .black
		
		configurePhysicsWorld()
		configureGameTimer(with: timerInterval)
		
		configureStarfield()
		configurePlayer()
		configureScoreLabel()
		
		score = 0
	}
    
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		determinePlayerPosition(for: touches)
	}
    
    override func update(_ currentTime: TimeInterval) {
		for childNode in children {
			if childNode.position.x < (Display.leftBound - 200) { childNode.removeFromParent() }
		}
		
		if !isGameOver { score += 1 }
    }
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard !isGameOver else { return }
		gameOver()
	}
	
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		determinePlayerPosition(for: touches) // player's position follows finger
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if !isGameOver { gameOver(); return } // challenge 1
	}
}


extension GameScene: SKPhysicsContactDelegate {
	
	private func configurePhysicsWorld() {
		physicsWorld.gravity			= CGVector(dx: 0, dy: 0)
		physicsWorld.contactDelegate	= self
	}
}


extension GameScene {
	
	private func configureStarfield() {
		starfield 			= EmitterNodes.starfield
		starfield.position 	= CGPoint(x: Display.width, y: Display.height / 2)
		starfield.zPosition = -1
		starfield.advanceSimulationTime(10)
		addChild(starfield)
	}
	
	private func configurePlayer() {
		player				= SpriteNodes.player
		player.position		= CGPoint(x: Display.leftBound + (player.size.width / 2), y: Display.height / 2)
		player.physicsBody	= SKPhysicsBody(texture: player.texture!, size: player.size) // per-pixel collision detection
		player.physicsBody?.contactTestBitMask = 1
		addChild(player)
	}
	
	private func configureScoreLabel() {
		scoreLabel			= LabelNodes.score
		scoreLabel.position	= CGPoint(x: Display.leftBound + 16, y: Display.bottomBound + 16)
		scoreLabel.name		= "Score label"
		scoreLabel.horizontalAlignmentMode	= .left
		addChild(scoreLabel)
	}
	
	private func configureGameTimer(with interval: Double) {
		gameTimer = Timer.scheduledTimer(
			timeInterval: interval,
			target: self,
			selector: #selector(createDebris),
			userInfo: nil,
			repeats: true
		)
	}
	
	@objc
	private func createDebris() {
		guard let debris = debris.randomElement(), !isGameOver else { return } // challenge 3
		
		let node							= SKSpriteNode(imageNamed: debris)
		node.physicsBody					= SKPhysicsBody(texture: node.texture!, size: node.size)
		node.physicsBody?.categoryBitMask	= 1
		node.physicsBody?.velocity			= CGVector(dx: -500, dy: 0)
		node.physicsBody?.linearDamping		= 0
		node.physicsBody?.angularVelocity	= 5
		node.physicsBody?.angularDamping	= 0
		node.position						= CGPoint(x: Display.width + 100, y: CGFloat.random(in: (Display.bottomBound + 50)...(Display.height - 32)))
		addChild(node)
		
		// challenge 2
		debrisBlockCount += 1
		if debrisBlockCount >= 20 {
			debrisBlockCount = 0
			timerInterval -= 0.1
			gameTimer?.invalidate()
			configureGameTimer(with: timerInterval)
		}
	}
	
	
	private func determinePlayerPosition(for touches: Set<UITouch>) {
		if let touch = touches.first {
			var location = touch.location(in: self)
			
			if location.y < Display.bottomBound + 100 { location.y = Display.bottomBound + 100 }
			else if location.y > Display.height - 100 { location.y = Display.height - 100 }
			player.position.y = location.y
		}
	}
	
	
	private func gameOver() {
		let explosion = EmitterNodes.explosion
		explosion.position = player.position
		addChild(explosion)
		
		player.removeFromParent()
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { explosion.removeFromParent() }
		isGameOver = true
		gameTimer?.invalidate()
	}
}
