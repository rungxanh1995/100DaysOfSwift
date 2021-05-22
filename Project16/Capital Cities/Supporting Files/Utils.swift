//
//  Utils.swift
//  Today
//
//  Created by Joe Pham on 2021-05-10.
//

import UIKit

class Utils {
	static func hapticOnUIElements() {
		let generator = UIImpactFeedbackGenerator(style: .light)
		generator.impactOccurred(intensity: 1.0)
	}
}
