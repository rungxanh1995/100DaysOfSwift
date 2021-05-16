//
//  GameScene.swift
//  Whack-a-penguin
//
//  Created by Joe Pham on 2021-05-15.
//

import SpriteKit

class GameScene: SKScene {
    private var gameScore: SKLabelNode!
    private var score = 0 {
        didSet { gameScore.text = "Score: \(score)"}
    }
	private var numRounds = 0
	private var maxNumRound = 30
    private var slots = [WhackSlot]()
    private var popupTime = 0.85
	private let gameOverSound = "gameOver.caf" // challenge 1
    
    override func didMove(to view: SKView) {
        setUpGameBackground()
        setUpGameScoreLabel()
        setUpRowsOfSlots()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.createBadPenguin()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		let tappedNodes = nodes(at: location)
		for node in tappedNodes {
			guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
				// as a whackslot is 2 level deep from a tapped node
			if !whackSlot.isVisible	{ continue }
			if whackSlot.isHit		{ continue }
			whackSlot.hit()
			
			if node.name == WhackSlot.goodPenguinName {
				score -= 5
				run(SKAction.playSoundFileNamed(WhackSlot.whackSound, waitForCompletion: false))
			} else if node.name == WhackSlot.badPenguinName {
				score += 1
				run(SKAction.playSoundFileNamed(WhackSlot.whackBadSound, waitForCompletion: false))
			}
		}
    }
}

extension GameScene {
    private func setUpGameBackground() {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: CGFloat(view?.bounds.midX ?? (1024 / 2)),
                                      y: CGFloat(view?.bounds.midY ?? (768 / 2)))
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
    }
    
    private func setUpGameScoreLabel() {
        gameScore = SKLabelNode(fontNamed: "Chalkduster")
        gameScore.fontSize = 48
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        addChild(gameScore)
    }
    
    fileprivate func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
    
    private func setUpRowsOfSlots() {
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) } // top row
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) } // 2nd row
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) } // 3rd row
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) } // bottom row
    }
    
	fileprivate func createGameOverLabel() {
		// stop popping up penguins when game ends
		let gameOverNode = SKSpriteNode(imageNamed: "gameOver")
		gameOverNode.position = CGPoint(x: CGFloat(view?.bounds.midX ?? (1024 / 2)),
										y: CGFloat(view?.bounds.midY ?? (768 / 2)))
		gameOverNode.zPosition = 1
		addChild(gameOverNode)
		// challenge 1
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
			self?.run(SKAction.playSoundFileNamed((self?.gameOverSound)! , waitForCompletion: false))
		}
	}
	
	// challenge 2
	fileprivate func createFinalScoreLabel() {
		let finalScoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		finalScoreLabel.text = "Final Score: \(score)"
		finalScoreLabel.zPosition = 1
		finalScoreLabel.position = CGPoint(
			x: CGFloat(view?.bounds.midX ?? (1024 / 2)),
			y: CGFloat(view?.bounds.midY ?? (768 / 2)) - 80
		)
		finalScoreLabel.horizontalAlignmentMode = .center
		finalScoreLabel.fontSize = 48
		finalScoreLabel.name = "finalScoreLabel"
		addChild(finalScoreLabel)
	}
	
	private func createBadPenguin() {
		if numRounds < maxNumRound {
			numRounds += 1
			popupTime *= 0.99 	// decreasing popup time of a bad penguin
			slots.shuffle()		// shuffle order of slots in slot list
			slots[0].show(hideTime: popupTime) // 1st bad penguin pop up
			
			// randomize a number to create more bad penguins
			if Int.random(in: 0...12) > 4  { slots[1].show(hideTime: popupTime) } // 2nd bad penguin pop up
			if Int.random(in: 0...12) > 8  { slots[2].show(hideTime: popupTime) } // 3rd bad penguin pop up
			if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) } // 4th bad penguin pop up
			if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime) } // 5th bad penguin pop up
			
			// self call function again after a delay
			let minDelay = popupTime * 0.5
			let maxDelay = popupTime * 2.0
			let delay = Double.random(in: minDelay...maxDelay)
			DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
				self?.createBadPenguin()
			}
		} else {
			for slot in slots { slot.hide() }
			createGameOverLabel()
			createFinalScoreLabel() // challenge 2
			return
		}
    }
}
