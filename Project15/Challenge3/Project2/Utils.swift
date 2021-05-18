//
//  File.swift
//  Project2
//
//  Created by Joe Pham on 2021-05-18.
//

import UIKit

let defaults = UserDefaults.standard
let globalQueue = DispatchQueue.global()
let mainQueue = DispatchQueue.main

func correctAnswerHaptic() {
	let generator = UINotificationFeedbackGenerator()
	generator.notificationOccurred(.success)
}

func wrongAnswerHaptic() {
	let generator = UINotificationFeedbackGenerator()
	generator.notificationOccurred(.error)
}
