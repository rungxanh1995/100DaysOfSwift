//
//  GameLayout.swift
//  Project8
//
//  Created by Joe Pham on 2021-05-17.
//

import UIKit

extension ViewController {
	
	func setUpGameLayout() {
		// Root view
		view = UIView()
		view.backgroundColor = .white
		
		createScoreLabel()
		createCluesLabel()
		createAnswersLabel()
		createCurrentAnswerField()
		
		let submitButton = UIButton(type: .system)
		submitButton.translatesAutoresizingMaskIntoConstraints = false
		submitButton.setTitle("SUBMIT", for: .normal)
		submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
		view.addSubview(submitButton)
		
		let clearButton = UIButton(type: .system)
		clearButton.translatesAutoresizingMaskIntoConstraints = false
		clearButton.setTitle("CLEAR", for: .normal)
		clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
		view.addSubview(clearButton)
		
		let buttonsView = UIView()
		buttonsView.translatesAutoresizingMaskIntoConstraints = false
		buttonsView.layer.borderWidth = 1
		buttonsView.layer.cornerRadius = 16
		buttonsView.layer.borderColor = UIColor.lightGray.cgColor
		view.addSubview(buttonsView)
		
		setUpContraints(submitButton, clearButton, buttonsView)
		setUpLetterButtons(buttonsView)
	}
	
	fileprivate func createScoreLabel() {
		scoreLabel = UILabel()
		scoreLabel.translatesAutoresizingMaskIntoConstraints = false
		scoreLabel.textAlignment = .right
		scoreLabel.text = "Score: 0"
		view.addSubview(scoreLabel)
	}
	
	fileprivate func createCluesLabel() {
		cluesLabel = UILabel()
		cluesLabel.translatesAutoresizingMaskIntoConstraints = false
		cluesLabel.font = UIFont.systemFont(ofSize: 24)
		cluesLabel.text = "CLUES"
		cluesLabel.numberOfLines = 0    // as many as it needs
		cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
		view.addSubview(cluesLabel)
	}
	
	fileprivate func createAnswersLabel() {
		answersLabel = UILabel()
		answersLabel.translatesAutoresizingMaskIntoConstraints = false
		answersLabel.font = UIFont.systemFont(ofSize: 24)
		answersLabel.text = "ANSWERS"
		answersLabel.numberOfLines = 0  // as many as it needs
		answersLabel.textAlignment = .right
		answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
		view.addSubview(answersLabel)
	}
	
	fileprivate func createCurrentAnswerField() {
		currentAnswer = UITextField()
		currentAnswer.translatesAutoresizingMaskIntoConstraints = false
		currentAnswer.placeholder = "Tap letters to guess"
		currentAnswer.textAlignment = .center
		currentAnswer.font = UIFont.systemFont(ofSize: 44)
		currentAnswer.isUserInteractionEnabled = false  // disable keyboard
		view.addSubview(currentAnswer)
	}
	
	fileprivate func setUpContraints(_ submitButton: UIButton, _ clearButton: UIButton, _ buttonsView: UIView) {
		NSLayoutConstraint.activate([
			scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
			scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
			cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
			cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
			cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
			answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
			answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
			answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
			answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
			currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
			currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
			submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 20),
			submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
			submitButton.heightAnchor.constraint(equalToConstant: 44),
			clearButton.centerYAnchor.constraint(equalTo: submitButton.centerYAnchor),
			clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
			clearButton.heightAnchor.constraint(equalToConstant: 44),
			buttonsView.widthAnchor.constraint(equalToConstant: 750),
			buttonsView.heightAnchor.constraint(equalToConstant: 320),
			buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
			buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
		])
	}
	
	fileprivate func setUpLetterButtons(_ buttonsView: UIView) {
		let buttonWidth = 150
		let buttonHeight = 80
		
		let maxButtonRowIndex = 3
		let maxButtonColumnIndex = 4
		for row in 0...maxButtonRowIndex {
			for column in 0...maxButtonColumnIndex {
				// Create a button and set font size
				let letterButton = UIButton(type: .system)
				letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
				letterButton.setTitle("ABC", for: .normal)
				letterButton.addTarget(self,
									   action: #selector(letterTapped),
									   for: .touchUpInside)
				
				let buttonFrame = CGRect(x: column * buttonWidth,
										 y: row * buttonHeight,
										 width: buttonWidth,
										 height: buttonHeight)
				letterButton.frame = buttonFrame
				buttonsView.addSubview(letterButton)
				letterButtons.append(letterButton)
			}
		}
	}
}
