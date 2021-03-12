//
//  ViewController.swift
//  Project2
//
//  Created by Joe Pham on 2021-01-06.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet var button1: UIButton!
	@IBOutlet var button2: UIButton!
	@IBOutlet var button3: UIButton!
	
	var countries = [String]()	// hold country names
	var score = 0				// hold player's current score
	
	var highScore = 0			// hold player's highest score
	let highScoreKey = "HighestScore"
	
	var correctAnswer = 0	  	// track the correct answer
	var currentQuestion = 0		// track the current question number
	
	let maxQuestions = 10
	
	let defaults = UserDefaults.standard
	let globalQ = DispatchQueue.global()
	let mainQ = DispatchQueue.main

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Sharing button
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
		
		// Fill up countries array with asset flags
		countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
		
		// Set borderWith of all buttons
		button1.layer.borderWidth = 1
		button2.layer.borderWidth = 1
		button3.layer.borderWidth = 1
		
		// Set borderColor of all buttons
		button1.layer.borderColor = UIColor(red: 0.86, green: 0.56, blue: 0.15, alpha: 1.00).cgColor
		button2.layer.borderColor = UIColor(red: 0.86, green: 0.56, blue: 0.15, alpha: 1.00).cgColor
		button3.layer.borderColor = UIColor(red: 0.86, green: 0.56, blue: 0.15, alpha: 1.00).cgColor
		
		askQuestion()
		
		// UNPACK SAVED DATA
		highScore = defaults.object(forKey: highScoreKey) as? Int ?? score
	}
	
	// METHOD TO GENERATE NEW QUESTION
	func askQuestion(action: UIAlertAction! = nil) {
		currentQuestion += 1
		
		if currentQuestion > maxQuestions {
			showResults()
			return
		}
		
		countries.shuffle()	// Shuffle the country names array
		correctAnswer = Int.random(in: 0...2) // Randomize the correct answer within first 3 items
		
		// Set image for each button as first 3 items of shuffled array
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		
		updateTitle()
	}

	// METHOD TO EXECUTE WHEN A FLAG BUTTON IS TAPPED
	@IBAction func buttonTapped(_ sender: UIButton) {
		// Declare a separate title property for button tapped action
		var title: String
		var message: String
		
		
		// Update value of title & score
		if sender.tag == correctAnswer {
			title = "Correct"
			score += 1
			message = "Score: \(score)"
		} else {
			title = "Wrong"
			score -= 1
			message = """
				You chose \(countries[sender.tag].uppercased())
				Flag of \(countries[correctAnswer].uppercased()) was #\(correctAnswer + 1)
				Score: \(score)
				"""
		}
		
		updateTitle()
		
		let continueAction = UIAlertAction(title: "Cotinue", style: .default, handler: askQuestion)
		
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
		ac.addAction(continueAction)
		present(ac, animated: true)
	}
	
	
	func updateTitle() {
		// Set title of ViewController to current correct answer index in the array & current score
		title = "\(countries[correctAnswer].uppercased())   SCORE: \(score)   \(currentQuestion)/\(maxQuestions)"
	}
	
	func showResults() {
		var message = "Questions asked: \(maxQuestions)\nFinal score: \(score)"
		
		var shouldSaveHighScore = false
		if score > highScore {
			message += "\n\nNEW HIGH SCORE!\nPrevious high score: \(highScore)"
			highScore = score
			shouldSaveHighScore = true
		}
		
		let restartAction = UIAlertAction(title: "Restart game", style: .default, handler: askQuestion)
		
		let ac = UIAlertController(title: "End of game", message: message, preferredStyle: .alert)
		ac.addAction(restartAction)
		
		self.present(ac, animated: true)
		
		score = 0
		correctAnswer = 0
		currentQuestion = 0
		
		if shouldSaveHighScore {
			globalQ.async { [weak self] in
				self?.saveHighScore()
			}
		}
	}
	
	// METHOD TO SHARE USER SCORE
	@objc func shareTapped() {
		let vc = UIActivityViewController(activityItems: ["Check it out, I got \(score)/\(maxQuestions) in this awesome flag game!"], applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}
	
	// METHOD TO SAVE SCORE
	func saveHighScore() {
		defaults.set(highScore, forKey: highScoreKey)
	}
}

