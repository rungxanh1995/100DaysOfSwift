//
//  GraphicsVC.swift
//  Core Graphics
//
//  Created by Joe Pham on 2021-08-10.
//

import UIKit

class GraphicsVC: UIViewController {
	
	var graphicsView: GraphicsView!
	var currentDrawType = 0

	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = Bundle.main.displayName
		configureGraphicsView()
		graphicsView.imageView.drawRectangle()
	}
	
}


extension GraphicsVC {
	
	final func configureGraphicsView() {
		graphicsView = GraphicsView(frame: view.bounds)
		view.addSubview(graphicsView)
		graphicsView.redrawButton.addTarget(self, action: #selector(didTapRedraw), for: .touchUpInside)
	}
	
	
	@objc
	final func didTapRedraw() {
		if currentDrawType < 5	{ currentDrawType += 1 }
		else					{ currentDrawType = 0 }
		
		let imageView = graphicsView.imageView
		
		switch currentDrawType {
		case 0:
			imageView.drawRectangle()
		case 1:
			imageView.drawCircle()
		case 2:
			imageView.drawCheckerboard(size: 16)
		case 3:
			imageView.drawRotatedSquares(squares: 16)
		case 4:
			imageView.drawAngledLines(angle: .pi, lines: 128)
		case 5:
			imageView.drawImageAndText()
		default:
			break
		}
	}
}

