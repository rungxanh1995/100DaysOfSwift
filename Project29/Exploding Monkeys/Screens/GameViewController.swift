//
//  GameViewController.swift
//  Exploding Monkeys
//
//  Created by Joe Pham on 2021-09-05.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
	
	// MARK: Properties
	var currentGameScene			: GameScene!
	@IBOutlet var angleSlider		: UISlider!
	@IBOutlet var velocitySlider	: UISlider!
	@IBOutlet var angleLabel		: UILabel!
	@IBOutlet var velocityLabel		: UILabel!
	@IBOutlet var launchButton		: UIButton!
	@IBOutlet var playerNumberLabel	: UILabel!
	
	
	// MARK: GameVC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
				
				// Embed scene in a UIKit view controller
				currentGameScene					= scene as? GameScene
				currentGameScene?.viewController	= self
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS			= true
            view.showsNodeCount		= true
        }
		
		angleDidChange(self)
		velocityDidChange(self)

    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
	

	@IBAction final func angleDidChange(_ sender: Any) {
		angleLabel.text = "Angle: \(Int(angleSlider.value))°"
	}
	
	
	@IBAction final func velocityDidChange(_ sender: Any) {
		velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
	}
	
	
	@IBAction final func didTapLaunch(_ sender: Any) {
		shouldHideUIElements(true, elements: angleSlider, angleLabel, velocitySlider, velocityLabel, playerNumberLabel)
		
		currentGameScene?.launchWith(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
	}
	
}


extension GameViewController {

	final func activatePlayer(_ name: String) {
		if name == NodeNames.player1	{ playerNumberLabel.text = "<- Player 1" }
		else							{ playerNumberLabel.text = "Player 2 ->" }
		shouldHideUIElements(false, elements: angleSlider, angleLabel, velocitySlider, velocityLabel, playerNumberLabel)
	}
	
}
