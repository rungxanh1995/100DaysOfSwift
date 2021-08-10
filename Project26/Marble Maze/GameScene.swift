//
//  GameScene.swift
//  Marble Maze
//
//  Created by Joe Pham on 2021-08-09.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
	
	// MARK: Properties
	
	// For motion detection on physical devices
	private var motionManager	: CMMotionManager!
	
	// For testing gameplay on simulator
	var lastTouchPosition		: CGPoint?
    
	// For game
	private var ball			: SKSpriteNode!
	private var startPosition	= CGPoint(x: 96, y: 672)
	private var scoreLabel		: SKLabelNode!
	private var score = 0 {
		didSet { scoreLabel.text = "Score: \(score)" }
	}
	
	private var currentLevel	= 1
	let maxNumLevels			= 4
	private var isGameOver		= false
	
	private var isPortalActive	= true // challenge 3
	
	
	// MARK: GameScene Life Cycle
	
	override func didMove(to view: SKView) {
		
		physicsWorld.contactDelegate = self
		
		// challenge 1
		configureMotionManager()

		configureGravity(in: self, value: .zero)
		configureBackground()
		configureScoreLabel()
		loadLevel(currentLevel)
		configureBall(at: startPosition)
		// end of challenge 1
	}
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		locateLastTouch(from: touches)
	}
	
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		locateLastTouch(from: touches)
	}
	
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		lastTouchPosition = nil
	}
	
	
	override func update(_ currentTime: TimeInterval) {
		
		guard isGameOver == false else { return }
		
		#if targetEnvironment(simulator)
		play(using: lastTouchPosition)
		#else
		play(using: motionManager)
		#endif
	}
}


extension GameScene: SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if nodeA == ball		{ ballCollided(with: nodeB) }
		else if nodeB == ball	{ ballCollided(with: nodeA) }
	}
	
	
	func didEnd(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if nodeA == ball		{ ballDidEndCollision(with: nodeB) }
		else if nodeB == ball	{ ballDidEndCollision(with: nodeA) }
	}
}


// challenge 1
extension GameScene {
	
	// MARK: Logic
	
	final func loadLevel(_ levelNumber: Int) {
		let fileName = "level\(levelNumber).txt"
		guard let levelUrl = Bundle.main.getPath(of: fileName) else { fatalError("Couldn't locate \(fileName) in app bundle.") }
		
		guard let levelString = try? String(contentsOf: levelUrl) else { fatalError("Couldn't load content of \(fileName) from app bundle.") }
		
		let lines = levelString.components(separatedBy: "\n")
		
		// loop in reverse as SpriteKit uses an inverted Y-axis
		for (row, line) in lines.reversed().enumerated() {
			for (col, char) in line.enumerated() {
				
				let unitSize = SKSpriteNode(imageNamed: Asset.Names.block).size.width
				let position = CGPoint(x: unitSize * CGFloat(col) + unitSize / 2,
									   y: unitSize * CGFloat(row) + unitSize / 2)
				
				if char == Symbols.wall			{ configureWallBlock(at: position, isDynamic: false) }
				else if char == Symbols.vortex	{ configureVortex(at: position, isDynamic: false) }
				else if char == Symbols.portal	{ configurePortal(at: position, isDynamic: false) } //challenge 3
				else if char == Symbols.star	{ configureStar(at: position, isDynamic: false) }
				else if char == Symbols.finish	{ configureFinish(at: position, isDynamic: false) }
				else if char == Symbols.space	{ }
				else							{ fatalError("Unknown level letter: \(char)") }
			}
		}
	}
	
	
	
	final func locateLastTouch(from touches: Set<UITouch>) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		lastTouchPosition = location
	}
	
	
	func play(using touch: CGPoint?) {
		if let currentTouch	= touch {
			let diff = CGPoint(x: currentTouch.x - ball.position.x, y: currentTouch.y - ball.position.y)
			let gravityFromTouch = CGVector(dx: diff.x / 100, dy: diff.y / 100)
			configureGravity(in: self, value: gravityFromTouch)
		}
	}
	
	
	func play(using motionManager: CMMotionManager?) {
		if let accelerometerData = motionManager?.accelerometerData {
			let accelerometerGravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
			configureGravity(in: self, value: accelerometerGravity)
		}
	}
	
	
	final func ballCollided(with node: SKNode) {
		
		switch node.name {
		
		case Asset.Names.vortex:
			ball.physicsBody?.isDynamic = false
			isGameOver					= true
			score						-= 1

			ball.suckedInto(node)
			configureBall(at: startPosition)
			isGameOver					= false
			
		case Asset.Names.portal: // challenge 3
			if isPortalActive {
				for nextNode in children where nextNode.name == Asset.Names.portal && nextNode != node {
					enterPortal(in: node, out: nextNode)
					break
				}
			}
			
		case Asset.Names.star:
			score						+= 1
			node.pulsateThenGone()
			
		case Asset.Names.finish:
			// challenge 2
			ball.suckedInto(node)
			node.pulsateThenGone()
			
			if currentLevel < maxNumLevels	{ currentLevel += 1 }
			else							{ currentLevel = 1 }
			loadLevel(currentLevel)
			
			score = 0
			configureBall(at: startPosition)
			return

		default:
			return
		}
		
		if isPortalActive == false && node.name != Asset.Names.portal { isPortalActive = true } // chaklenge 3
		// if the player went to a different collision directly after a portal,
		// didEnd won't be called
	}
	
	
	// challenge 3
	final func enterPortal(in portalIn: SKNode, out portalOut: SKNode) {
		ball.physicsBody?.isDynamic = false
		ball.suckedInto(portalIn)
		exitPortal(out: portalOut)
	}
	
	// challenge 3
	final func exitPortal(out portalOut: SKNode) {
		configureBall(at: portalOut.position)
		isPortalActive = false // deactivate portal until ball moves out of it
	}
	
	
	// challenge 3
	final func ballDidEndCollision(with node: SKNode) {
		guard node.name == Asset.Names.portal else { return }
		isPortalActive	= true
	}
	
	
	private func configureMotionManager() {
		motionManager = CMMotionManager()
		motionManager.startAccelerometerUpdates()
	}
	
	
	final func configureGravity(in scene: SKScene, value gravity: CGVector) {
		scene.physicsWorld.gravity = gravity
	}
}


// challenge 1
extension GameScene {
	
	// MARK: UI Config
	
	final func configureBackground() {
		let background							= SKSpriteNode(imageNamed: Asset.Names.background)
		background.position						= CGPoint(x: Display.width / 2, y: Display.height / 2)
		background.zPosition					= -1
		background.blendMode					= .replace
		addChild(background)
	}
	
	
	final func configureScoreLabel() {
		scoreLabel								= SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.text							= "Score: 0"
		scoreLabel.fontSize						= 40
		scoreLabel.position						= CGPoint(x: Display.leftEdge + 8, y: Display.bottomEdge + 8)
		scoreLabel.zPosition					= 2
		scoreLabel.horizontalAlignmentMode 		= .left
		addChild(scoreLabel)
	}
	
	
	final func configureBall(at position: CGPoint) {
		ball									= SKSpriteNode(imageNamed: Asset.Names.ball)
		ball.position							= position
		ball.zPosition							= 1
		
		ball.physicsBody						= SKPhysicsBody(circleOfRadius: ball.size.width / 2)
		ball.physicsBody?.allowsRotation		= true
		ball.physicsBody?.linearDamping			= 0.5
		ball.physicsBody?.categoryBitMask		= CollisionTypes.ball.rawValue
		ball.physicsBody?.collisionBitMask		= CollisionTypes.wall.rawValue
		ball.physicsBody?.contactTestBitMask	= CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
		
		addChild(ball)
	}
	
	
	final func configureWallBlock(at position: CGPoint, isDynamic: Bool) {
		let block								= SKSpriteNode(imageNamed: Asset.Names.block)
		block.position							= position
		
		block.physicsBody						= SKPhysicsBody(rectangleOf: block.size)
		block.physicsBody?.isDynamic			= false
		block.physicsBody?.categoryBitMask		= CollisionTypes.wall.rawValue
		
		addChild(block)
	}
	
	
	final func configureVortex(at position: CGPoint, isDynamic: Bool) {
		let vortex								= SKSpriteNode(imageNamed: Asset.Names.vortex)
		vortex.name								= Asset.Names.vortex
		vortex.position							= position
		
		vortex.physicsBody						= SKPhysicsBody(circleOfRadius: vortex.size.width / 2)
		vortex.physicsBody?.isDynamic			= isDynamic
		vortex.physicsBody?.categoryBitMask		= CollisionTypes.vortex.rawValue
		vortex.physicsBody?.contactTestBitMask	= CollisionTypes.ball.rawValue
		vortex.physicsBody?.collisionBitMask	= 0
		
		vortex.rorateForever()
		addChild(vortex)
	}
	
	
	// challenge 3
	final func configurePortal(at position: CGPoint, isDynamic: Bool) {
		let portal								= SKSpriteNode(imageNamed: Asset.Names.portal)
		portal.name								= Asset.Names.portal
		portal.position							= position
		
		portal.physicsBody						= SKPhysicsBody(circleOfRadius: portal.size.width / 2)
		portal.physicsBody?.isDynamic			= isDynamic
		portal.physicsBody?.categoryBitMask		= CollisionTypes.portal.rawValue
		portal.physicsBody?.contactTestBitMask	= CollisionTypes.ball.rawValue
		portal.physicsBody?.collisionBitMask	= 0
		
		portal.rotateWithPulse()
		addChild(portal)
	}
	
	
	final func configureStar(at position: CGPoint, isDynamic: Bool) {
		let star								= SKSpriteNode(imageNamed: Asset.Names.star)
		star.name								= Asset.Names.star
		star.position							= position
		
		star.physicsBody						= SKPhysicsBody(circleOfRadius: star.size.width / 2)
		star.physicsBody?.isDynamic				= isDynamic
		star.physicsBody?.categoryBitMask		= CollisionTypes.star.rawValue
		star.physicsBody?.contactTestBitMask	= CollisionTypes.ball.rawValue
		star.physicsBody?.collisionBitMask		= CollisionTypes.none.rawValue
		
		star.wiggleForever()
		addChild(star)
	}
	
	
	final func configureFinish(at position: CGPoint, isDynamic: Bool) {
		let finish								= SKSpriteNode(imageNamed: Asset.Names.finish)
		finish.name 							= Asset.Names.finish
		finish.position 						= position

		finish.physicsBody 						= SKPhysicsBody(circleOfRadius: finish.size.width / 2)
		finish.physicsBody?.isDynamic 			= false
		finish.physicsBody?.categoryBitMask 	= CollisionTypes.finish.rawValue
		finish.physicsBody?.contactTestBitMask 	= CollisionTypes.ball.rawValue
		finish.physicsBody?.collisionBitMask 	= CollisionTypes.none.rawValue
		
		finish.wiggleForever(leftAndRight: true)
		addChild(finish)
	}
}
