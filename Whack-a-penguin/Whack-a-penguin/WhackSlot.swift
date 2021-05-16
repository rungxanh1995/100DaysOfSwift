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
	static public let goodPenguinName = "penguinGood"
	static public let badPenguinName = "penguinBad"
	static public let whackBadSound	= "whackBad.caf"
	static public let whackSound = "whack.caf"
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let holeNode = SKSpriteNode(imageNamed: "whackHole")
        addChild(holeNode)
        
        penguinNode = SKSpriteNode(imageNamed: "penguinGood")
        penguinNode.position = CGPoint(x: 0, y: -90)
        penguinNode.name = "penguinGood"
        
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
        penguinNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.1)) // slide a penguin ↑
        isVisible = true
		isHit = false
        
        // Establish that 1/3 of the time penguin is good, rest of the time it is bad
        if Int.random(in: 0...2) == 0 {
			penguinNode.texture = SKTexture(imageNamed: WhackSlot.goodPenguinName)
			penguinNode.name = WhackSlot.goodPenguinName
        } else {
			penguinNode.texture = SKTexture(imageNamed: WhackSlot.badPenguinName)
			penguinNode.name = WhackSlot.badPenguinName
        }
		
		DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
			self?.hide()
		}
    }
    
    func hide() {
		if !(isVisible) { return }
		penguinNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.1)) // slide a penguin ↓
		isVisible = false
    }
	
	func hit() { // handles the hiding of penguins
		isHit = true
		penguinNode.setScale(0.85)
		
		let delay = SKAction.wait(forDuration: 0.25) // wait for a while after hitting
		let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
		let notVisible = SKAction.run { [weak self] in self?.isVisible = false }
		penguinNode.run(SKAction.sequence([delay, hide, notVisible]))
	}
}
