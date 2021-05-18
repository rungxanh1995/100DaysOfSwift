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
	
	private var countries = [String]()
	private var score = 0
	private var highScore = 0
	private let highScoreKey = "HighestScore"
	
	var correctAnswer = 0
	var currentQuestion = 0
	static let maxQuestions = 10
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadCountries()
		setUpFlagButtons()
		askQuestion()
		highScore = defaults.object(forKey: highScoreKey) as? Int ?? score
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
															target: self,
															action: #selector(shareTapped))
	}
}

extension ViewController {
	fileprivate func loadCountries() {
		countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
	}
	
	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String
		var message: String
		
		if sender.tag == correctAnswer {
			correctAnswerHaptic()
			score += 1
			title = "Correct"
			message = "Score: \(score)"
		} else {
			wrongAnswerHaptic()
			score -= 1
			title = "Wrong"
			message = """
				You chose \(countries[sender.tag].uppercased())
				Flag of \(countries[correctAnswer].uppercased()) was #\(correctAnswer + 1)
				Score: \(score)
				"""
		}
		updateTitle()
		animateButton(sender, buttonState: .shrink)
		mainQueue.asyncAfter(deadline: .now() + 0.25, execute: { [weak self] in
			self?.animateButton(sender, buttonState: .original)
			let continueAction = UIAlertAction(title: "Cotinue",
											   style: .default,
											   handler: self?.askQuestion)
			let ac = UIAlertController(title: title,
									   message: message,
									   preferredStyle: .alert)
			ac.addAction(continueAction)
			self?.present(ac, animated: true)
		})
	}
	
	fileprivate func askQuestion(action: UIAlertAction! = nil) {
		if currentQuestion >= Self.maxQuestions {
			showResults()
			return
		} else {
			currentQuestion += 1
			askNewQuestion()
			updateTitle()
		}
	}
		
	fileprivate func askNewQuestion() {
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2) // Randomize the correct answer within first 3 items
		
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
	}
			
	fileprivate func saveHighScore() {
		defaults.set(highScore, forKey: highScoreKey)
	}
}

extension ViewController {
	// UI stuff
	fileprivate func setUpFlagButtons() {
		let radius = CGFloat(20)
		button1.layer.borderWidth = 1
		button1.layer.borderColor = UIColor.systemGray.cgColor
		button1.layer.cornerRadius = radius
		button1.layer.masksToBounds = true
		button2.layer.borderWidth = 1
		button2.layer.borderColor = UIColor.systemGray.cgColor
		button2.layer.cornerRadius = radius
		button2.layer.masksToBounds = true
		button3.layer.borderWidth = 1
		button3.layer.borderColor = UIColor.systemGray.cgColor
		button3.layer.cornerRadius = radius
		button3.layer.masksToBounds = true
	}
	
	fileprivate func updateTitle() {
		title = "\(countries[correctAnswer].uppercased())   SCORE: \(score)   \(currentQuestion)/\(Self.maxQuestions)"
	}
	
	private enum ButtonAnimation {
		case shrink
		case original
	}
	
	private func animateButton(_ sender: UIButton, buttonState: ButtonAnimation) {
		UIView.animate(withDuration: 0.25,
					   delay: 0,
					   usingSpringWithDamping: 0.5,
					   initialSpringVelocity: 10,
					   animations: {
						switch buttonState {
						case .shrink:
							sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
						case .original:
							sender.transform = .identity
						}
					   })
	}
	
	fileprivate func showResults() {
		var message = "Questions asked: \(Self.maxQuestions)\nFinal score: \(score)"
		var shouldSaveHighScore = false
		if score > highScore {
			message += "\n\nNEW HIGH SCORE!\nPrevious high score: \(highScore)"
			highScore = score
			shouldSaveHighScore = true
		}
		
		let restartAction = UIAlertAction(title: "Restart game",
										  style: .default,
										  handler: askQuestion)
		let ac = UIAlertController(title: "End of game",
								   message: message,
								   preferredStyle: .alert)
		ac.addAction(restartAction)
		self.present(ac, animated: true)
		
		score = 0
		correctAnswer = 0
		currentQuestion = 0
		if shouldSaveHighScore {
			globalQueue.async { [weak self] in
				self?.saveHighScore()
			}
		}
	}
	
	@objc
	fileprivate func shareTapped() {
		let vc = UIActivityViewController(
			activityItems: ["Check it out, I got \(score)/\(Self.maxQuestions) in this awesome flag game!"],
			applicationActivities: [])
		vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		present(vc, animated: true)
	}
}
