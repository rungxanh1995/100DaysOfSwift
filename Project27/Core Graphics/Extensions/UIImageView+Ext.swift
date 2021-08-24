//
//  UIImageView+Ext.swift
//  Core Graphics
//
//  Created by Joe Pham on 2021-08-20.
//

import UIKit.UIImageView

extension UIImageView {
	
	func drawRectangle() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: ScreenSize.width, height: ScreenSize.width))

		let image = renderer.image { context in
			let rectangle = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.width).insetBy(dx: Graphic.edgePadding, dy: Graphic.edgePadding)
			context.cgContext.setFillColor(UIColor.systemPink.cgColor)
			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.setLineWidth(5)
			
			context.cgContext.addRect(rectangle)
			context.cgContext.drawPath(using: .fillStroke)
		}
		self.image = image
	}
	
	
	func drawCircle() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: ScreenSize.width, height: ScreenSize.width))

		let image = renderer.image { context in
			let rectangle = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.width).insetBy(dx: Graphic.edgePadding, dy: Graphic.edgePadding)
			context.cgContext.setFillColor(UIColor.systemPink.cgColor)
			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.setLineWidth(5)
			
			context.cgContext.addEllipse(in: rectangle)
			context.cgContext.drawPath(using: .fillStroke)
		}
		self.image = image
	}
	
	
	func drawCheckerboard(size: Int) {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: ScreenSize.width, height: ScreenSize.width))
		
		let image = renderer.image { context in
			context.cgContext.setFillColor(UIColor.black.cgColor)
			
			for row in 0..<size {
				for col in 0..<size {
					let cellSize = 32
					if (row + col) % 2 == 0 {
						context.cgContext.fill(CGRect(x: col * cellSize, y: row * cellSize, width: cellSize, height: cellSize))
					}
				}
			}
		}
		self.image = image
	}
	
	
	func drawRotatedSquares(squares numberOfSquares: Int) {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: ScreenSize.width, height: ScreenSize.width))
		
		let image = renderer.image { context in
			context.cgContext.translateBy(x: ScreenSize.width / 2, y: ScreenSize.width / 2)
			
			let rotations	= numberOfSquares
			let amount		= CGFloat.pi / CGFloat(rotations)
			
			for _ in 0..<rotations {
				context.cgContext.rotate(by: amount)
				context.cgContext.addRect(CGRect(x: -(ScreenSize.width / 4), y: -(ScreenSize.width / 4), width: ScreenSize.width / 2, height: ScreenSize.width / 2))
			}
			
			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.strokePath()
		}
		self.image = image
	}
	
	
	func drawAngledLines(angle: CGFloat, lines numberOfLines: Int) {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: ScreenSize.width, height: ScreenSize.width))
		
		let image = renderer.image { context in
			context.cgContext.translateBy(x: ScreenSize.width / 2, y: ScreenSize.width / 2)
			
			var isFirstLine			= true
			var lineLength: CGFloat = ScreenSize.width / 2
			
			for _ in 0..<numberOfLines {
				context.cgContext.rotate(by: angle / 2)
				
				if isFirstLine {
					context.cgContext.move(to: CGPoint(x: lineLength, y: 50))
					isFirstLine = false
				} else {
					context.cgContext.addLine(to: CGPoint(x: lineLength, y: 50))
				}
				
				lineLength *= 0.99
			}
			
			context.cgContext.setStrokeColor(UIColor.black.cgColor)
			context.cgContext.strokePath()
		}
		self.image = image
	}
	
	
	func drawImageAndText() {
		let renderer = UIGraphicsImageRenderer(size: CGSize(width: ScreenSize.width, height: ScreenSize.width))
		
		let image = renderer.image { context in
			
			let paragraphStyle			= NSMutableParagraphStyle()
			paragraphStyle.alignment	= .center
			
			let loremString				= "Eligendi deleniti et voluptatem sed delectus facilis dolore est eveniet ratione dolorum quis sapiente."
			let attributes: [NSAttributedString.Key: Any] = [
				.font:					UIFont.preferredFont(forTextStyle: .headline),
				.paragraphStyle:		paragraphStyle
			]
			let attributedString		= NSAttributedString(string: loremString, attributes: attributes)
			attributedString.draw(with: CGRect(x: 0, y: 0, width: ScreenSize.width, height: 100), options: .usesLineFragmentOrigin, context: nil)
			
			
			let image					= UIImage(named: "swift-icon")
			image?.draw(at: CGPoint(x: 0, y: 100))
		}
		self.image = image
	}
}
