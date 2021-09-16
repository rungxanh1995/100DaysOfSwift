//
//  GameScene.swift
//  Exploding Monkeys
//
//  Created by Joe Pham on 2021-09-05.
//

import SpriteKit

class GameScene: SKScene {
	
    // MARK: Properties
	weak var viewController	: GameViewController!
	private var buildings	= [BuildingNode]()
	private var player1		: SKSpriteNode!
	private var player2		: SKSpriteNode!
	private var banana		: SKSpriteNode!
	
	private var currentPlayer = NodeNames.player1
	
	
	// MARK: Life Cycle
    override func didMove(to view: SKView) {
		physicsWorld.contactDelegate = self
		setUpScene()
    }
	
	
	override func update(_ currentTime: TimeInterval) {
		guard banana != nil else { return }
		
		if abs(banana.position.y) > Display.rightEdge {
			banana.removeFromParent()
			banana = nil
			changePlayer()
		}
	}
}


// MARK: - Logic
extension GameScene {
	
	private func presentNewGame() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
			guard let self = self else { return }
			
			let newGame				= GameScene(size: self.size)
			newGame.viewController	= self.viewController
			self.viewController.currentGameScene = newGame
			
			self.changePlayer()
			newGame.currentPlayer	= self.currentPlayer
			
			let transition			= SKTransition.doorway(withDuration: 1.5)
			self.view?.presentScene(newGame, transition: transition)
		}
	}
	
	
	final func changePlayer() {
		
		if currentPlayer == NodeNames.player1	{ currentPlayer = NodeNames.player2 }
		else									{ currentPlayer = NodeNames.player1 }
		
		viewController.activatePlayer(currentPlayer)
	}
	
	
	final func launchWith(angle: Int, velocity: Int) {
		let bananaSpeed = Double(velocity) / 10.0
		let radians		= deg2Rad(angle)
		
		if banana != nil	{
			banana.removeFromParent()
			banana = nil
		}
		
		createBanana()
		
		if currentPlayer == NodeNames.player1 {
			banana.position = CGPoint(x: player1.position.x - 30, y: player1.position.y + 40)
			banana.physicsBody?.angularVelocity = -20
			
			banana.animateThrow(arm: .left, node: player1) { [weak self] in
				let impulse = CGVector(dx: cos(radians) * bananaSpeed, dy: sin(radians) * bananaSpeed)
				self?.banana.physicsBody?.applyImpulse(impulse)
			}
		} else {
			banana.position = CGPoint(x: player2.position.x + 30, y: player2.position.y + 40)
			banana.physicsBody?.angularVelocity = 20
			
			banana.animateThrow(arm: .right, node: player2) { [weak self] in
				let impulse = CGVector(dx: cos(radians) * -bananaSpeed, dy: sin(radians) * bananaSpeed)
				self?.banana.physicsBody?.applyImpulse(impulse)
			}
		}
	}
	
	
	final func deg2Rad(_ degrees: Int) -> Double {
		return Double(degrees) * Double.pi / 180.0
	}
	
	
	final func showExplosion(at position: CGPoint) {
		if let explosion = SKEmitterNode(fileNamed: "hitPlayer") {
			explosion.position = position
			addChild(explosion)
		}
	}
	
	
	final func bananaHit(building: SKNode, atPosition contactPoint: CGPoint) {
		
		guard let building = building as? BuildingNode else { return }
		
		let buildingLocation = convert(contactPoint, to: building)
		building.hit(at: buildingLocation)
		
		showExplosion(at: contactPoint)
		
		banana.name = ""
		banana.removeFromParent()
		banana		= nil
		
		changePlayer()
	}
}


// MARK: - Physic Contact

extension GameScene: SKPhysicsContactDelegate {
	
	func didBegin(_ contact: SKPhysicsContact) {
		let firstBody		: SKPhysicsBody
		let secondBody		: SKPhysicsBody
		
		if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
			firstBody		= contact.bodyA
			secondBody		= contact.bodyB
		} else {
			firstBody		= contact.bodyB
			secondBody		= contact.bodyA
		}
		
		guard
			let firstNode	= firstBody.node,
			let secondNode	= secondBody.node
		else { return }
		
		if firstNode.name == NodeNames.banana && secondNode.name == NodeNames.building {
			bananaHit(building: secondNode, atPosition: contact.contactPoint)
		}
		
		if firstNode.name == NodeNames.banana && secondNode.name == NodeNames.player1 {
			showExplosion(at: player1.position)
			removeFromParent(player1, banana)
			presentNewGame()
		}
		
		if firstNode.name == NodeNames.banana && secondNode.name == NodeNames.player2 {
			showExplosion(at: player2.position)
			removeFromParent(player2, banana)
			presentNewGame()
		}
	}
}


// MARK: - UI Config
extension GameScene {
	
	final func setUpScene() {
		backgroundColor = Colors.sky
		createBuildings()
		createPlayers()
	}
	
	
	final func createBuildings() {
		var currentX			= Display.leftEdge - 15
		let padding: CGFloat	= 2
		
		while currentX < Display.rightEdge {
			let buildingSize	= CGSize(width: Int.random(in: 2...4) * 40, height: Int.random(in: 300...600))
			currentX			+= buildingSize.width + padding
			
			let building		= BuildingNode(color: UIColor.red, size: buildingSize)
			building.position	= CGPoint(x: currentX - (buildingSize.width / 2), y: buildingSize.height / 2)
			building.setUp()
			addChild(building)
			
			buildings.append(building)
		}
	}
	
	
	final func createPlayers() {
		
		player1									= SKSpriteNode(imageNamed: "player")
		player1.name							= NodeNames.player1
		player1.physicsBody						= SKPhysicsBody(circleOfRadius: player1.size.width / 2)
		player1.physicsBody?.categoryBitMask	= CollisionTypes.monkey.rawValue
		player1.physicsBody?.collisionBitMask	= CollisionTypes.banana.rawValue
		player1.physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue
		player1.physicsBody?.isDynamic			= false
		
		let player1Bldg							= buildings[1]
		player1.position						= CGPoint(x: player1Bldg.position.x, y: player1Bldg.position.y + ((player1Bldg.size.height + player1.size.height) / 2))
		addChild(player1)
		
		
		player2									= SKSpriteNode(imageNamed: "player")
		player2.name							= NodeNames.player2
		player2.physicsBody						= SKPhysicsBody(circleOfRadius: player2.size.width / 2)
		player2.physicsBody?.categoryBitMask	= CollisionTypes.monkey.rawValue
		player2.physicsBody?.collisionBitMask	= CollisionTypes.banana.rawValue
		player2.physicsBody?.contactTestBitMask = CollisionTypes.banana.rawValue
		player2.physicsBody?.isDynamic			= false
		
		let player2Bldg							= buildings[buildings.count - 2]
		player2.position						= CGPoint(x: player2Bldg.position.x, y: player2Bldg.position.y + ((player2Bldg.size.height + player2.size.height) / 2))
		addChild(player2)
	}
	
	
	final func createBanana() {
		banana									= SKSpriteNode(imageNamed: NodeNames.banana)
		banana.name								= NodeNames.banana
		banana.physicsBody						= SKPhysicsBody(circleOfRadius: banana.size.width / 2)
		banana.physicsBody?.categoryBitMask		= CollisionTypes.banana.rawValue
		banana.physicsBody?.collisionBitMask	= CollisionTypes.building.rawValue | CollisionTypes.monkey.rawValue
		banana.physicsBody?.contactTestBitMask	= CollisionTypes.building.rawValue | CollisionTypes.monkey.rawValue
		banana.physicsBody?.usesPreciseCollisionDetection = true
		addChild(banana)
	}
}
