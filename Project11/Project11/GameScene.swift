//
//  GameScene.swift
//  Project11
//
//  Created by Joe Pham on 2021-02-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ballNames: [String] = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
    
    var ballsLabel: SKLabelNode!    // force unwrapped, this balls label to be defined in didMove()
    var balls = 5 {
        didSet {
            ballsLabel.text = "Balls: \(balls)"
        }
    }
    
    var boxesLabel: SKLabelNode!    // force unwrapped, this balls label to be defined in didMove()
    var boxCount = 0 {
        didSet {
            boxesLabel.text = "Boxes: \(boxCount)"
        }
    }
    
    var editingLabel: SKLabelNode!  // allow players to edit the game scene
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editingLabel.text = "Done"  // label text hints to "Done" while in editing mode
            } else {
                editingLabel.text = "Edit"  // label text hints to "Edit" while NOT in editing mode
            }
        }
    }
    
    var ballRewardedLabel: SKLabelNode!
    var ballRewarded = "" {
        didSet {
            ballRewardedLabel.text = "\(ballRewarded)"
        }
    }
    
    var gameResultLabel: SKLabelNode!
    var gameResult = "" {
        didSet {
            gameResultLabel.text = "\(gameResult)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        // ADD A PHYSICS BODY TO THE SCENE
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)    // a line on each edge
        // acting like a container for the scene
        
        physicsWorld.contactDelegate = self // assign the current scene to physics world's contact delegate
        
        // DEFINE THE GAME BACKGROUND
        let background = SKSpriteNode(imageNamed: "background_ocean.jpg")
        background.position = CGPoint(x: 512, y: 384)   // half the scene size
        background.blendMode = .replace // ignore any alpha values
        background.zPosition = -1   // place the background below everything else
        addChild(background)    // background is a node
        
        // CREATE THE SLOTS (SO IT'S BEHIND THE BOUNCERS)
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        // CREATE THE BOUNCERS
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        // DEFINE THE BALLS LABEL
        ballsLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsLabel.text = "Balls: 5"    // initial value
        ballsLabel.horizontalAlignmentMode = .right
        ballsLabel.position = CGPoint(x: 980, y: 700)
        addChild(ballsLabel)
        
        // DEFINE THE BOXES LABEL
        boxesLabel = SKLabelNode(fontNamed: "Chalkduster")
        boxesLabel.text = "Boxes: 0"    // initial value
        boxesLabel.horizontalAlignmentMode = .right
        boxesLabel.position = CGPoint(x: 980, y: 660)
        addChild(boxesLabel)
        
        // DEFINE THE EDITING LABEL
        editingLabel = SKLabelNode(fontNamed: "Chalkduster")
        editingLabel.text = "Edit"
        editingLabel.horizontalAlignmentMode = .left
        editingLabel.position = CGPoint(x: 44, y: 700)
        addChild(editingLabel)
        
        // DEFINE THE BALL REWARDED LABEL
        ballRewardedLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballRewardedLabel.horizontalAlignmentMode = .left
        ballRewardedLabel.position = CGPoint(x: 44, y: 660)
        addChild(ballRewardedLabel)
        
        // DEFINE THE GAME RESULT LABEL
        gameResultLabel = SKLabelNode(fontNamed: "Chalkduster")
        gameResultLabel.fontSize = 80
        gameResultLabel.position = CGPoint(x: 512, y: 384)
        addChild(gameResultLabel)
    }
    
    
    // DEFINE THE BOUNCER(s)
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer.jpg")
        bouncer.position = position    // pass the x,y coords to the position property of the bouncer
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false  // being false means it's gonna stay in place, not moving
        addChild(bouncer)
    }
    
    
    // DEFINE THE SLOT(s)
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"  // name this node the good slot
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"   // name this node the bad slot
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)    // add rectangle physics
        slotBase.physicsBody?.isDynamic = false // keep it still
        
        // Make the glow spins, forever
        let spin = SKAction.rotate(byAngle: (-CGFloat.pi), duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
        
        addChild(slotBase)
        addChild(slotGlow)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // DEFINE A TOUCH ON THE SCREEN
        if let touch = touches.first    // pull out any screen touches from `touches` set
        {
            let location = touch.location(in: self) // find out where the screen was touched in relation to self/the game scene
            
            let objects = nodes(at: location)   // get a list of objects at a specific location
            if objects.contains(editingLabel) {
                // if that location has the editing label
                editingMode.toggle()    // toggle means change to true if currently false, and vice versa
            } else {
                if editingMode {
                    // hide some obstructive text
                    gameResult = "" // hide the game result if in edit mode
                    ballRewarded = ""   // display nothing if in edit mode
                    
                    // create a box
                    let size = CGSize(width: Int.random(in: 32...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.name = "box"    // name this node
                    box.zRotation = CGFloat.random(in: 0...3)   // let each box rotates randomly
                    box.position = location // create the box at that touch point
                    
                    box.physicsBody = SKPhysicsBody(rectangleOf: size)  // add a physics body to the box
                    box.physicsBody?.isDynamic = false
                    
                    addChild(box)
                    boxCount += 1
                } else {
                    // create the balls
                    let randomInt = Int.random(in: 0..<ballNames.count)
                    let ballName = ballNames[randomInt] // generate random-colored balls
                    
                    let ball = SKSpriteNode(imageNamed: "\(ballName)")
                    ball.name = "ball"  // name this node
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0) // add a circular physics body to the ball with radius of half the image width
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask   // let it tell about every collision that happens to the ball
                    ball.physicsBody?.restitution = 0.4 // change its bounciness within 0-1 range
                    ball.position = location // place the ball where the touch happened
                    ball.position.y = CGFloat(768)  // let the ball fall from top of the screen
                    
                    // MAINLINE DECISION TREE for adding balls and showing game result
                    if balls > 0 {  // allow adding more balls upon a touch only when still having balls left
                        if boxCount > 0 {
                            gameResult = ""
                        } else {    // when no boxes onscreen but still have balls
                            gameResult = "Add boxes to play"
                        }
                        addChild(ball)   // add the ball to the scene at that touch
                        balls -= 1  // decrement the number of balls left
                        ballRewarded = ""   // display nothing when a ball is created
                    }
                    else {    // otherwise if run out of balls, regardless of boxes
                        gameResult = "GAME OVER"
                    }
                }
            }
        }
    }
    
    
    // DEFINE HOW AN ITEM IS REMOVED FROM THE NODE TREE
    func destroy(item: SKNode) {
        if let bubbles = SKEmitterNode(fileNamed: "Bubbles") {  // create bubbles effect
            bubbles.position = item.position  // the position where the ball would be removed
            addChild(bubbles)
        }
        item.removeFromParent()
    }
    
    
    // DEFINE A COLLISION BETWEEN AN ITEM AND OTHER OBJECTS WOULD WORK
    func collisionBetween(item: SKNode, anotherItem: SKNode) {
        if anotherItem.name == "good" {
            destroy(item: item) // call the destroy method defined below
            balls += 1  // reward 1 more ball
            ballRewarded = "Free ball 🥳";  // cheer user up
        } else if anotherItem.name == "bad" {
            destroy(item: item)
            ballRewarded = "Oops 😬";   // play it better bud
        } else if anotherItem.name == "box" {
            destroy(item: anotherItem)
            boxCount -= 1
        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        // WHEN PHYSICS CONTACT HAPPENS
        // ignore the case if both bodies are balls, we don't want them to disappear when they're both balls
        
        // have a guard to prevent force unwrapping an already removed ball node
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        // decide how the ball or box should be removed upon collision
        if nodeA.name == "ball" || nodeB.name == "box" {
            collisionBetween(item: nodeA, anotherItem: nodeB)
        } else if nodeB.name == "ball" || nodeA.name == "box" {
            collisionBetween(item: nodeB, anotherItem: nodeA)
        }
    }
}
