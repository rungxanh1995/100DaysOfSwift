//
//  Utils.swift
//  Today
//
//  Created by Joe Pham on 2021-05-10.
//

import UIKit

enum HapticFeedback {
	static func hapticOnUIElements() {
		let generator = UIImpactFeedbackGenerator(style: .light)
		generator.impactOccurred(intensity: 1.0)
	}
}
