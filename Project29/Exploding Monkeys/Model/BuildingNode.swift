//
//  BuildingNode.swift
//  Exploding Monkeys
//
//  Created by Joe Pham on 2021-09-05.
//

import SpriteKit.SKSpriteNode

class BuildingNode: SKSpriteNode {

	private var currentImage			: UIImage!
	
	func setUp() {
		name							= NodeNames.building
		currentImage					= drawBuilding(size: size)
		texture							= SKTexture(image: currentImage)
		configurePhysics()
	}
	

	func hit(at point: CGPoint) {
		let convertedPoint = CGPoint(x: point.x + size.width / 2.0, y: abs(point.y - (size.height / 2.0)))
		
		let renderer = UIGraphicsImageRenderer(size: size)
		let image = renderer.image { context in
			currentImage.draw(at: .zero)
			
			context.cgContext.addEllipse(in: CGRect(x: convertedPoint.x - 32, y: convertedPoint.y - 32, width: 64, height: 64))
			context.cgContext.setBlendMode(.clear)
			context.cgContext.drawPath(using: .fill)
		}
		
		texture			= SKTexture(image: image)
		currentImage	= image
		
		configurePhysics()
	}
	
	
	private func configurePhysics() {
		physicsBody						= SKPhysicsBody(texture: texture!, size: size)
		physicsBody?.isDynamic			= false
		physicsBody?.categoryBitMask	= CollisionTypes.building.rawValue
		physicsBody?.contactTestBitMask	= CollisionTypes.banana.rawValue
	}
	
	
	private func drawBuilding(size: CGSize) -> UIImage {
		
		let renderer		= UIGraphicsImageRenderer(size: size)
		let buildingImage	= renderer.image { context in
			let rectangle	= CGRect(x: 0, y: 0, width: size.width, height: size.height)
			let color		: UIColor
			
			// draw block
			switch Int.random(in: 0...2) {
			case 0: 	color = Colors.building1
			case 1:		color = Colors.building2
			default:	color = Colors.building3
			}
			
			color.setFill()
			UIColor.black.setStroke()
			context.cgContext.addRect(rectangle)
			context.cgContext.drawPath(using: .fillStroke)
			
			// draw lights
			for row in stride(from: 10, to: Int(size.height - 10), by: 40) {
				for col in stride(from: 10, to: Int(size.width - 10), by: 40) {
					
					switch Bool.random() {
					case true:	Colors.buildingLightOn.setFill()
					case false: Colors.buildingLightOff.setFill()
					}
					
					context.cgContext.fill(CGRect(x: col, y: row, width: 15, height: 20))
				}
			}
		}
		return buildingImage
	}
}
