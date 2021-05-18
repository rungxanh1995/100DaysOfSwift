//
//  ViewController.swift
//  Project15
//
//  Created by Joe Pham on 2021-05-17.
//

import UIKit

class ViewController: UIViewController {
	
	private var imageView: UIImageView!
	private var currentAnimation = 0
	static let penguinImageName = "penguin"

	override func viewDidLoad() {
		super.viewDidLoad()
		addPenguin()
	}
	
	@IBAction func buttonTapped(_ sender: UIButton) {
		sender.isHidden = true
		animatePenguin(sender)
		if currentAnimation < 7 {
			currentAnimation += 1
		} else {
			currentAnimation = 0
		}
	}
}

extension ViewController {
	
	private func addPenguin() {
		imageView = UIImageView(image: UIImage(named: Self.penguinImageName))
		imageView.center = CGPoint(x: view.bounds.width / 2,
								   y: view.bounds.height / 2)
		view.addSubview(imageView)
	}
	
	fileprivate func animatePenguin(_ sender: UIButton) {
		UIView.animate(
			withDuration: 1,
			delay: 0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 10,
			options: [],
			animations: {
				switch self.currentAnimation {
				case 0:
					self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
				case 1:
					self.imageView.transform = .identity // reset to original state
				case 2:
					self.imageView.transform = CGAffineTransform(
						translationX: -(self.view.bounds.width / 2),
						y: -(self.view.bounds.height / 2)
					) // screen top left corner
				case 3:
					self.imageView.transform = .identity // reset to original state
				case 4:
					self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
				case 5:
					self.imageView.transform = .identity // reset to original state
				case 6:
					self.imageView.alpha = 0.1
					self.imageView.backgroundColor = .orange
					self.imageView.layer.cornerRadius = 8
					self.imageView.layer.masksToBounds = true
				case 7:
					self.imageView.alpha = 1
					self.imageView.backgroundColor = .clear
				default:
					break
				}
			},
			completion: { _ in
				sender.isHidden = false
			}
		)
	}
}

