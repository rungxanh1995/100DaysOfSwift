//
//  WhackSlot.swift
//  Whack-a-penguin
//
//  Created by Joe Pham on 2021-05-16.
//

import SpriteKit

class WhackSlot: SKNode {
    private var penguinNode: SKSpriteNode!
    private var isVisible = false
    private var isHit = false
    
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
        penguinNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.1)) // slide a penguin ↑
        isVisible = true; isHit = false
        
        // Establish that 1/3 of the time penguin is good, rest of the time it is bad
        if Int.random(in: 0...2) == 0 {
            penguinNode.texture = SKTexture(imageNamed: "penguinGood")
            penguinNode.name = "penguinGood"
        } else {
            penguinNode.texture = SKTexture(imageNamed: "penguinBad")
            penguinNode.name = "penguinBad"
        }
		
		DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
			self?.hide()
		}
    }
    
    fileprivate func hide() {
		if !(isVisible) { return }
		penguinNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.1)) // slide a penguin ↓
		isVisible = false
    }
}
