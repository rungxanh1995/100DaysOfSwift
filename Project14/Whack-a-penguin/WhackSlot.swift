//
//  WhackSlot.swift
//  Whack-a-penguin
//
//  Created by Joe Pham on 2021-05-16.
//

import SpriteKit

class WhackSlot: SKNode {
    private var penguinNode: SKSpriteNode!
    var isVisible = false
    var isHit = false
	static let goodPenguinName = "penguinGood"
	static let badPenguinName = "penguinBad"
	static let whackBadSound = "whackBad.caf"
	static let whackSound = "whack.caf"
	static let smokeEffectName = "Smoke" // challenge 3
	static let mudEffectName = "Mud"	// challenge 3
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let holeNode = SKSpriteNode(imageNamed: "whackHole")
        addChild(holeNode)
        
        penguinNode = SKSpriteNode(imageNamed: Self.goodPenguinName)
        penguinNode.position = CGPoint(x: 0, y: -90)
		penguinNode.name = Self.goodPenguinName
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask") // hide penguin at first
        cropNode.addChild(penguinNode)
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
		// NOTE: hideTime makes use of popupTime property in the view controller
        if isVisible { return }
		penguinNode.setScale(1.0)
		emitMudEffect(moving: .up) // challenge 3
        penguinNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.1)) // slide a penguin ↑
        isVisible = true
		isHit = false
        
        // Establish that 1/3 of the time penguin is good, rest of the time it is bad
        if Int.random(in: 0...2) == 0 {
			penguinNode.texture = SKTexture(imageNamed: Self.goodPenguinName)
			penguinNode.name = Self.goodPenguinName
        } else {
			penguinNode.texture = SKTexture(imageNamed: Self.badPenguinName)
			penguinNode.name = Self.badPenguinName
        }
		
		DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
			self?.hide()
		}
    }
    
    func hide() {
		if !(isVisible) { return }
		penguinNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.1)) // slide a penguin ↓
		emitMudEffect(moving: .down) // challenge 3
		isVisible = false
    }
	
	func hit() { // handles the hiding of penguins
		isHit = true
		penguinNode.setScale(0.85)
		emitSmokeEffect() // challenge 3
		let delay = SKAction.wait(forDuration: 0.25) // wait for a while after hitting
		let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
		let notVisible = SKAction.run { [weak self] in self?.isVisible = false }
		penguinNode.run(SKAction.sequence([delay, hide, notVisible]))
	}
}

// challenge 3
extension WhackSlot {
	private enum CharacterDirection {
		case up
		case down
	}
	
	private func runEffectWithSequence(_ effect: SKEmitterNode) {
		// this function removes the emitter node after a pre-set time
		let action	 = SKAction.run { [weak self] in self?.addChild(effect) }
		let duration = SKAction.wait(forDuration: 2)
		let removal  = SKAction.run { [weak self] in self?.removeChildren(in: [effect]) }
		run(SKAction.sequence([action, duration, removal]))
	}
	
	private func emitMudEffect(moving direction: CharacterDirection) {
		if let mudEffect = SKEmitterNode(fileNamed: Self.mudEffectName) {
			switch direction {
			case .up:
				mudEffect.particleLifetime = 0.30
				mudEffect.particleSpeed = 1
				mudEffect.particleSpeedRange = 200
			case .down:
				mudEffect.particleLifetime = 0.10
				mudEffect.particleSpeed = 100
				mudEffect.particleSpeedRange = 0
			}
			mudEffect.position = CGPoint(x: 0, y: 0)
			mudEffect.zPosition = 1
			mudEffect.numParticlesToEmit = 100
			mudEffect.particleBirthRate = 500
			mudEffect.particleSize = CGSize(width: 30, height: 30)
			mudEffect.particleColor = SKColor.brown
			mudEffect.particleBlendMode = .replace
			runEffectWithSequence(mudEffect)
		}
	}
	
	fileprivate func emitSmokeEffect() {
		if let smokeEffect = SKEmitterNode(fileNamed: Self.smokeEffectName) {
			smokeEffect.position = CGPoint(x: 0, y: 45)
			smokeEffect.zPosition = 1
			smokeEffect.numParticlesToEmit = 10
			smokeEffect.particleLifetime = 0.75
			smokeEffect.particleColor = SKColor.white
			smokeEffect.particleAlpha = 0.5
			runEffectWithSequence(smokeEffect)
		}
	}
}
