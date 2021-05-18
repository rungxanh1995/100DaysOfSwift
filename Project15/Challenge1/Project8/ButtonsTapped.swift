//
//  UIButtonsTapped.swift
//  Project8
//
//  Created by Joe Pham on 2021-05-17.
//

import UIKit

extension ViewController {
	@objc
	func letterTapped(_ sender: UIButton) {
		guard let buttonTitle = sender.titleLabel?.text else { return }
		currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
		activatedButtons.append(sender)
		sender.alpha = 0.1
		sender.isUserInteractionEnabled = false
	}
	
	@objc
	func submitTapped(_ sender: UIButton) {
		guard let answerText = currentAnswer.text else { return }
		if let answerPosition = possibleAnswers.firstIndex(of: answerText) {
			activatedButtons.removeAll()
			var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
			splitAnswers?[answerPosition] = answerText
			answersLabel.text = splitAnswers?.joined(separator: "\n")
			currentAnswer.text = ""
			
			score += 1
			
			if answersLabel.text?.contains("letters") != true {
				let ac = UIAlertController(title: AlertContext.nextLevelAlert.title,
										   message: AlertContext.nextLevelAlert.message,
										   preferredStyle: .alert)
				ac.addAction(UIAlertAction(title: AlertContext.nextLevelAlert.buttonTitle,
										   style: .default,
										   handler: levelUp))
				present(ac, animated: true)
			}
		} else {
			// If no answers found, show an alert
			let ac = UIAlertController(title: AlertContext.wrongWordAlert.title,
									   message: AlertContext.wrongWordAlert.message,
									   preferredStyle: .alert)
			ac.addAction(UIAlertAction(title: AlertContext.wrongWordAlert.buttonTitle,
									   style: .default,
									   handler: nil))
			present(ac, animated: true)
			
			score -= 1
			clearTapped(sender)
		}
	}
	
	@objc
	func clearTapped(_ sender: UIButton) {
		currentAnswer.text = ""
		for btn in activatedButtons {
			btn.alpha = 1
			btn.isUserInteractionEnabled = true
		}
		activatedButtons.removeAll()
	}
}
