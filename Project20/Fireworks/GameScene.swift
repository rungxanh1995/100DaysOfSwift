//
//  GameScene.swift
//  Fireworks
//
//  Created by Joe Pham on 2021-07-18.
//

import SpriteKit

class GameScene: SKScene {
	
	var gameTimer: Timer?
	var fireworks 		= [SKNode]()
	
	let leftEdge 		= GameScreenEdges.left
	let bottomEdge 		= GameScreenEdges.bottom
	let rightEdge 		= GameScreenEdges.right
    
	var scoreLabel: SKLabelNode! // challenge 1
	var score = 0 {
		didSet { scoreLabel.text = "Score: \(score)"}
	}
	
	var gameOverLabel: SKLabelNode! // challenge 2
	var launchCount		= 0			// challenge 2
	let maxLaunches		= 20
	
	
	override func didMove(to view: SKView) {
		super.didMove(to: view)
		configureGameBackground()
		configureGameTimer()
		configureScoreLabel()
		score = 0
	}
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesBegan(touches, with: event)
		checkTouches(in: touches)
	}
	
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesMoved(touches, with: event)
		checkTouches(in: touches)
	}
	
	
	private func checkTouches(in touches: Set<UITouch>) {
		guard let touch 		= touches.first else { return }
		let location 			= touch.location(in: self)
		let nodesAtTappedPoint 	= nodes(at: location)
		
		for case let node as SKSpriteNode in nodesAtTappedPoint {
			
			guard node.name == NodeNames.firework else { continue }
			
			for parent in fireworks {
				guard let firework = parent.children.first as? SKSpriteNode else { continue }
				if firework.name == NodeNames.selected && firework.color != node.color {
					firework.name				= NodeNames.firework
					firework.colorBlendFactor	= 1
				}
			}
			
			node.name				= NodeNames.selected
			node.colorBlendFactor	= 0
		}
	}
	
	
	override func update(_ currentTime: TimeInterval) {
		removeFireworksWhenOffScreen()
	}
}


extension GameScene {
	func explodeFireworks(isDeviceShaking: Bool) {
		guard isDeviceShaking else { return }
		var numExploded = 0
		
		for (i, fireworkContainer) in fireworks.enumerated().reversed() {
			guard let firework = fireworkContainer.children.first as? SKSpriteNode else { continue }
			if firework.name == NodeNames.selected {
				explode(node: fireworkContainer)
				fireworks.remove(at: i)
				numExploded += 1
			}
		}
		
		switch numExploded {
		case 0: 	break
		case 1: 	score += 200
		case 2: 	score += 500
		case 3: 	score += 1500
		case 4: 	score += 2500
		default:	score += 4000
		}
	}
}
