//
//  GameScene.swift
//  Penguin-Ninja
//
//  Created by Joe Pham on 2021-07-31.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
	// MARK: Properties
	
	// Graphics
	private var gameScore:			SKLabelNode!
	
	private var activeEnemies		= [SKSpriteNode]()
	
	private var activeSlicePoints	= [CGPoint]()
	private var activeSliceBackground: SKShapeNode!
	private var activeSliceForeground: SKShapeNode!
	
	private var livesImages			= [SKSpriteNode]()
	private var numLives			= 3
    
	// Sounds
	private var isSwooshSoundActive = false
	
	private var bombSoundEffect: AVAudioPlayer?
	
	// For logic
	private var isGameEnded			= false
	
	private var score = 0 {
		didSet { gameScore.text = "Score: \(score)" }
	}
	
	private var enemyScreenTime		= 0.9
	private var chainDelay			= 3.0	// for chain + fastChain cases
	private var sequence			= SequenceType.initialPattern
	private var sequenceIndex		= 0
	private var nextSequenceQueued	= true
	
	
	// MARK: GameScene Methods
	
    override func didMove(to view: SKView) {
		configurePhysicsWorld()
		configureBackground()
		
		configureScore()
		configureLives()
		createSlices()
		
		let addedSequences = SequenceType.generateRandomSequence(loops: 100)
		sequence += addedSequences
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in self?.tossEnemies() } // first penguin
    }
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		activeSlicePoints.removeAll(keepingCapacity: true)
		
		addSlicePoints(with: touches)
		
		activeSliceBackground.removeAllActions()
		activeSliceForeground.removeAllActions()
		
		activeSliceBackground.alpha = 1
		activeSliceForeground.alpha = 1
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if isGameEnded { return }
		
		addSlicePoints(with: touches)
		if !(isSwooshSoundActive) { playSwooshSound() }
		
		didSliceEnemies(under: touches)
	}
	
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		fadeOutActiveSlice()
	}
	
	
	override func update(_ currentTime: TimeInterval) {
		countBombsToStopSound()
		
		if activeEnemies.count > 0	{ enemyDidGoOffscreen(distance: 160) }
		else						{ queueUpNextSequenceToTossEnemies() }
    }
}


// MARK: Main Logic

extension GameScene {
	
	final func createEnemy(forceBomb: ForceBomb = .random) {
		
		var enemyType = Int.random(in: 0...6) // DON'T CHANGE THIS! NEEDED TO CREATE PENGUINS
		
		if		forceBomb == .no	{ enemyType = 1 }
		else if forceBomb == .yes	{ enemyType = 0 }
		
		let enemy: SKSpriteNode
		if enemyType == 0 {
			// bomb code goes here
			// 1
			enemy				= SKSpriteNode() // act as container of a bomb image + fuse emitter
			enemy.name			= Asset.Name.bombContainer
			enemy.zPosition		= 1
			
			// 2
			let bombImage		= SKSpriteNode(imageNamed: Asset.Name.bomb)
			bombImage.name		= Asset.Name.bomb
			enemy.addChild(bombImage)
			
			// 3
			if bombSoundEffect != nil { fadeOutBombSound() }
			
			// 4
			if let soundPath	= Bundle.main.getPath(of: Asset.Sound.bombFuse) {
				if let sound	= try? AVAudioPlayer(contentsOf: soundPath) {
					bombSoundEffect = sound
					sound.play()
				}
			}
			
			// 5
			if let fuse			= SKEmitterNode(fileNamed: Asset.Name.sliceFuse) {
				fuse.position	= CGPoint(x: 76, y: 64)
				enemy.addChild(fuse)
			}
		} else if enemyType == 6 {
			// challenge 2
			enemy				= SKSpriteNode(imageNamed: Asset.Name.penguinRed)
			enemy.name			= Asset.Name.penguinRed
			enemy.zPosition		= 0
			run(SKAction.playSoundFileNamed(Asset.Sound.launch, waitForCompletion: false))
		} else {
			enemy				= SKSpriteNode(imageNamed: Asset.Name.penguin)
			enemy.name			= Asset.Name.penguin
			enemy.zPosition		= 0
			run(SKAction.playSoundFileNamed(Asset.Sound.launch, waitForCompletion: false))
		}
		
		// position code goes here
		// 1
		let randXPosition		= CGFloat.random(in: (Display.leftEdge + 64)...(Display.rightEdge - 64))
		let randPosition		= CGPoint(x: randXPosition, y: Display.bottomEdge - 100)
		enemy.position			= randPosition
		
		// 2
		let randXVelocity: Int
		if		randPosition.x < Display.xGridLine1	{ randXVelocity = Int.random(in: 8...15)  }
		else if randPosition.x < Display.xGridLine2	{ randXVelocity = Int.random(in: 3...5)   }
		else if randPosition.x < Display.xGridLine3	{ randXVelocity = -Int.random(in: 3...5)  }
		else										{ randXVelocity = -Int.random(in: 8...15) }
		
		// 3
		let randYVelocity		= Int.random(in: 24...32)
		let randAngularVelocity = CGFloat.random(in: -3...3)
		
		// 4
		// challenge 2
		if enemyType == 6 {
			configurePhysicsBody(for: enemy, radius: 64, xVelocity: randXVelocity * 60, yVelocity: randYVelocity * 40, angularVelocity: randAngularVelocity, bitMask: 0)
		} else {
			configurePhysicsBody(for: enemy, radius: 64, xVelocity: randXVelocity * 40, yVelocity: randYVelocity * 40, angularVelocity: randAngularVelocity, bitMask: 0)
		}
		
		// 5
		addChild(enemy)
		activeEnemies.append(enemy)
	}
	
	
	final func tossEnemies() {
		if isGameEnded { return }
		
		enemyScreenTime		*= 0.99
		chainDelay			*= 0.99
		physicsWorld.speed	*= 1.02
		
		let sequenceType = sequence[sequenceIndex]
		
		switch sequenceType {
		
		case .oneNoBomb:
			createEnemy(forceBomb: .no)
		case .one:
			createEnemy()
		case .twoWithOneBomb:
			createEnemy(forceBomb: .no)
			createEnemy(forceBomb: .yes)
		case .two:
			createEnemy()
			createEnemy()
		case .three:
			createEnemy()
			createEnemy()
			createEnemy()
		case .four:
			createEnemy()
			createEnemy()
			createEnemy()
			createEnemy()
		case .chain:
			let delay = chainDelay / 5.0
			createEnemy()
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 1)	{ [weak self] in self?.createEnemy() }
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 2) { [weak self] in self?.createEnemy() }
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 3) { [weak self] in self?.createEnemy() }
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 4) { [weak self] in self?.createEnemy() }
		case .fastChain:
			let delay = chainDelay / 10.0
			createEnemy()
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 1)	{ [weak self] in self?.createEnemy() }
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 2) { [weak self] in self?.createEnemy() }
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 3) { [weak self] in self?.createEnemy() }
			DispatchQueue.main.asyncAfter(deadline: .now() + delay * 4) { [weak self] in self?.createEnemy() }
		}
		
		sequenceIndex		+= 1
		nextSequenceQueued	= false
	}
	
	
	private func queueUpNextSequenceToTossEnemies() {
		if !(nextSequenceQueued) {
			DispatchQueue.main.asyncAfter(deadline: .now() + enemyScreenTime) { [weak self] in self?.tossEnemies() }
			
			nextSequenceQueued = true
		}
	}
	
	
	private func enemyDidGoOffscreen(distance: CGFloat) {
		
		for (index, node) in activeEnemies.enumerated().reversed()
		where (node.position.x < Display.leftEdge - distance)
			|| (node.position.x > Display.rightEdge + distance)
			|| (node.position.y < Display.bottomEdge - distance)
		{
			if node.name == Asset.Name.penguin || node.name == Asset.Name.penguinRed { subtractLife() }
			
			node.name = nil
			node.removeAllActions()
			node.removeFromParent()
			activeEnemies.remove(at: index)
		}
		
	}
	
	
	final func didSliceEnemies(under touches: Set<UITouch>) {
		
		guard let touch = touches.first else { return }
		let location	= touch.location(in: self)
		let nodesAtTap	= nodes(at: location)
		
		for case let node as SKSpriteNode in nodesAtTap {
			if node.name == Asset.Name.penguin	{
				score += 1
				explodeEnemy(at: node)
			}
			else if node.name == Asset.Name.penguinRed {
				// challenge 2
				score += 5
				explodeEnemy(at: node)
			}
			else if node.name == Asset.Name.bomb {
				guard let bombContainer = node.parent as? SKSpriteNode else { continue }
				explodeEnemy(at: bombContainer)
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
					self?.endGame(triggeredByBomb: true)
				}
			}
		}
	}
	
	
	final func explodeEnemy(at node: SKSpriteNode) {
		
		let emitterFileName		= (node.name == Asset.Name.penguin || node.name == Asset.Name.penguinRed) ? Asset.Name.sliceHitEnemy : Asset.Name.sliceHitBomb
		if let emitter			= SKEmitterNode(fileNamed: emitterFileName) {
			emitter.position	= node.position
			addChild(emitter)
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) { emitter.removeFromParent() }
		}
		
		let removalSequence		= SKAction.sequence([GraphicAction.zoomOut, .removeFromParent()])
		node.run(removalSequence)

		if let i				= activeEnemies.firstIndex(of: node) { activeEnemies.remove(at: i) }
		
		let soundFileName		= (node.name == Asset.Name.penguin || node.name == Asset.Name.penguinRed) ? Asset.Sound.whack : Asset.Sound.explosion
		let sound				= SKAction.playSoundFileNamed(soundFileName, waitForCompletion: false)
		run(sound)
		
		node.name				= nil
	}
	
	
	final func subtractLife() {
		numLives				-= 1

		var lifeImage: SKSpriteNode
		if numLives == 2		{ lifeImage = livesImages[0] }
		else  if numLives == 1	{ lifeImage = livesImages[1] }
		else					{ lifeImage = livesImages[2]; endGame(triggeredByBomb: false) }
		
		lifeImage.texture		= SKTexture(imageNamed: Asset.Name.lifeGone)
		lifeImage.scale(to: CGSize(width: 1.3, height: 1.3))
		lifeImage.run(SKAction.scale(to: 1, duration: 0.2))
		
		run(SKAction.playSoundFileNamed(Asset.Sound.wrong, waitForCompletion: false))
	}
	
	final func endGame(triggeredByBomb: Bool) {
		if isGameEnded { return }

		if triggeredByBomb {
			livesImages.forEach { lifeImage in
				lifeImage.texture = SKTexture(imageNamed: Asset.Name.lifeGone)
			}
		}
		
		configureGameOverLabel() // challenge 3
		fadeOutBombSound()
		isGameEnded					= true
		physicsWorld.speed			= 0
		isUserInteractionEnabled	= false
	}
}


// MARK: Helpers

extension GameScene {
	
	final func configurePhysicsWorld() {
		physicsWorld.gravity		= CGVector(dx: 0, dy: -6)
		physicsWorld.speed			= 0.85
	}
	
	
	final func configurePhysicsBody(for node: SKSpriteNode, radius: CGFloat, xVelocity: Int, yVelocity: Int, angularVelocity: CGFloat, bitMask: UInt32) {
		node.physicsBody					= SKPhysicsBody(circleOfRadius: radius)
		node.physicsBody?.velocity			= CGVector(dx: xVelocity, dy: yVelocity)
		node.physicsBody?.angularVelocity	= angularVelocity
		node.physicsBody?.collisionBitMask	= bitMask
	}
	
	
	final func configureBackground() {
		let background						= SKSpriteNode(imageNamed: Asset.Name.background)
		background.position					= CGPoint(x: Display.width / 2, y: Display.height / 2)
		background.zPosition				= -1
		background.blendMode				= .replace
		addChild(background)
	}
	
	
	final func configureScore() {
		gameScore							= SKLabelNode(fontNamed: "Chalkduster")
		gameScore.fontSize					= 40
		gameScore.position					= CGPoint(x: Display.leftEdge + 8, y: Display.bottomEdge + 8)
		gameScore.horizontalAlignmentMode 	= .left
		addChild(gameScore)
		
		score = 0
	}
	
	
	// challenge 3
	final func configureGameOverLabel() {
		let gameOver						= SKLabelNode(fontNamed: "Chalkduster")
		gameOver.fontSize					= 60
		gameOver.text						= "GAME OVER!"
		gameOver.position					= CGPoint(x: Display.width / 2, y: Display.height / 2)
		gameOver.zPosition					= 999
		gameOver.horizontalAlignmentMode	= .center
		addChild(gameOver)
	}

	
	final func createSlices() {
		
		activeSliceBackground				= SKShapeNode()
		activeSliceBackground.lineWidth		= 9
		activeSliceBackground.zPosition		= 2
		activeSliceBackground.strokeColor	= UIColor(red: 1, green: 0.9, blue: 0, alpha: 1)
		addChild(activeSliceBackground)
		
		activeSliceForeground				= SKShapeNode()
		activeSliceForeground.lineWidth		= 5
		activeSliceForeground.zPosition		= 3
		activeSliceForeground.strokeColor	= UIColor.white
		addChild(activeSliceForeground)
	}
	
	
	final func fadeOutActiveSlice() {
		
		activeSliceBackground.run(GraphicAction.fadeOut)
		activeSliceForeground.run(GraphicAction.fadeOut)
	}
	
	
	final func addSlicePoints(with touches: Set<UITouch>) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		activeSlicePoints.append(location)
		redrawActiveSlice()
	}
	
	
	final func redrawActiveSlice() {
		// back out if not enough touch points to draw a line
		if activeSlicePoints.count < TouchPoint.minimum {
			activeSliceBackground.path 		= nil
			activeSliceForeground.path 		= nil
			return
		}
		
		// stop the swipe from being too long
		if activeSlicePoints.count > TouchPoint.maximum { activeSlicePoints.removeFirst(activeSlicePoints.count - TouchPoint.maximum) }
		
		// logic to draw a swipe
		let path = UIBezierPath()
		path.move(to: activeSlicePoints[0])
		
		for i in 1..<activeSlicePoints.count { path.addLine(to: activeSlicePoints[i]) }
		
		activeSliceBackground.path 			= path.cgPath
		activeSliceForeground.path 			= path.cgPath
	}
	
	
	final func playSwooshSound() {
		isSwooshSoundActive = true
		
		let soundNames		= [Asset.Sound.swoosh1, Asset.Sound.swoosh2, Asset.Sound.swoosh3]
		let sound			= SKAction.playSoundFileNamed(soundNames.randomElement()!, waitForCompletion: isSwooshSoundActive)
		run(sound) { [weak self] in self?.isSwooshSoundActive = false }
	}
	
	
	final func fadeOutBombSound() {
		bombSoundEffect?.setVolume(0, fadeDuration: 0.5)
	}
	
	
	final func countBombsToStopSound() {
		var bombCount = 0
		for node in activeEnemies where node.name == Asset.Name.bombContainer { bombCount += 1; break}
		if bombCount == 0 { fadeOutBombSound() }
	}
	
	
	final func configureLives() {
		
		let startXPoint: CGFloat	= Display.rightEdge - 48
		let nodeSize: CGFloat		= 70
		
		for i in 0..<numLives {
			let lifeNode			= SKSpriteNode(imageNamed: Asset.Name.life)
			lifeNode.position		= CGPoint(x: startXPoint - (CGFloat(i) * nodeSize), y: Display.topEdge - 48)
			addChild(lifeNode)
			
			livesImages.append(lifeNode)
		}
	}
}
