//
//  ViewController.swift
//  Hangman
//
//  Created by Joe Pham on 2021-04-17.
//

import UIKit

class ViewController: UIViewController {
	
	// MARK: - Main vars & consts
	let alphabets: [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"] // all English alphabetic letters
	var wordsToGuess = [String]()
	var wordToGuess: String = "" // word to guess in a level
	var answerLabel: UILabel! // to display hidden word
	var hiddenWord: String = "" {
		didSet {
			answerLabel.text = "\(hiddenWord)"
		}
	}
	var guessAttempts: Int = 0 // track number of guess attempts for each word
	var letterButtons: [UIButton] = [UIButton]()
	
	// MARK: - loadView()
	override func loadView() {
		view = UIView()
		view.backgroundColor = .black
		
		loadWords()
		
		answerLabel = UILabel()
		answerLabel.translatesAutoresizingMaskIntoConstraints = false
		answerLabel.text = generateRandomWord()
		answerLabel.font = UIFont(name: "Chalkduster", size: 32)
		answerLabel.textColor = .white
		view.addSubview(answerLabel)
		
		let letterButtonsView = UIView() // view for all alphabet buttons
		letterButtonsView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(letterButtonsView)
		
		// initial hangman bar images
		let lineImage1 = UIImageView(frame: CGRect(x: 100, y: 170, width: 9, height: 300))
		lineImage1.translatesAutoresizingMaskIntoConstraints = false
		lineImage1.backgroundColor = .white
		view.addSubview(lineImage1) // main vertical bar
		
		let lineImage2 = UIImageView(frame: CGRect(x: 60, y: 470, width: 130, height: 10))
		lineImage2.translatesAutoresizingMaskIntoConstraints = false
		lineImage2.backgroundColor = .white
		view.addSubview(lineImage2) // horizontal base bar
		
		let lineImage3 = UIImageView(frame: CGRect(x: 100, y: 170, width: 160, height: 8))
		lineImage3.translatesAutoresizingMaskIntoConstraints = false
		lineImage3.backgroundColor = .white
		view.addSubview(lineImage3) // upper horizontal bar
		
		let lineImage4 = UIImageView(frame: CGRect(x: 260, y: 170, width: 6, height: 30))
		lineImage4.translatesAutoresizingMaskIntoConstraints = false
		lineImage4.backgroundColor = .white
		view.addSubview(lineImage4) // vertical bar that hangs man
		
		drawLine(fromX: 106, toX: 152, fromY: 220, toY: 176) // diagonal bar
		
		NSLayoutConstraint.activate([
			answerLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
			answerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			letterButtonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			letterButtonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
			letterButtonsView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 1),
			letterButtonsView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.4)
		])
		
		// Create all letter buttons
		let width: Int = 73, height: Int = 55
		
		for row in 0..<5 {
			for col in 0..<5 {
				let letterButton = UIButton(type: .system)
				letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
				letterButton.setTitle("A", for: .normal)
				
				let frame = CGRect(x: (width * col), y: (height * row), width: width, height: height)
				letterButton.frame = frame
				
				letterButtons.append(letterButton)
				letterButtonsView.addSubview(letterButton)
				
				letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
			}
		}
		
		let lastLetterButton = UIButton(type: .system)
		lastLetterButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
		lastLetterButton.setTitle("A", for: .normal)
		let frame = CGRect(x: (width * 2), y: (height * 5), width: width, height: height)
		lastLetterButton.frame = frame
		
		letterButtons.append(lastLetterButton)
		letterButtonsView.addSubview(lastLetterButton)
		lastLetterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
	}
	
	// MARK: - viewDidLoad()
	override func viewDidLoad() {
		super.viewDidLoad()
		loadGame()
	}
	
	// MARK: - Helper funcs
	
	func loadWords() {
		if let wordsURL = Bundle.main.url(forResource: "Words", withExtension: "txt") {
			if let words = try? String(contentsOf: wordsURL) {
				wordsToGuess = words.components(separatedBy: "\n")
			}
		}
	}
	
	func generateRandomWord() -> String {
		wordToGuess = wordsToGuess.randomElement()!
		hiddenWord = wordToGuess // TODO: CONSIDER REMOVING THIS IF NOT USE
		hiddenWord.removeAll(keepingCapacity: true)
		
		for _ in 0..<wordToGuess.count { hiddenWord.append("?") }
		return hiddenWord
	}
	
	func drawLine(fromX: Int, toX: Int, fromY: Int, toY: Int) -> Void {
		let path = UIBezierPath()
		path.move(to: CGPoint(x: fromX, y: fromY))
		path.addLine(to: CGPoint(x: toX, y: toY))
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = path.cgPath
		shapeLayer.strokeColor = UIColor.white.cgColor
		shapeLayer.lineWidth = 4.0
		
		view.layer.addSublayer(shapeLayer)
	}
	
	func nameTheButtons() {
		for button in letterButtons { button.isHidden = false }
		
		for i in 0..<letterButtons.count { letterButtons[i].setTitle(String(alphabets[i]), for: .normal) }
	}
	
	@objc func letterTapped(_ sender: UIButton) {
		guard let buttonTitle = sender.titleLabel?.text else { return }
		
		let title = Character(buttonTitle)
		
		for letter in wordToGuess { // iterate each letter in word to guess
			if letter == title { // if this word has a letter that user has tapped
				guard let index = wordToGuess.firstIndex(of: title) else { return } // position of this letter in the word
				guard let lastIndex = wordToGuess.lastIndex(of: title) else { return } // position of last letter in the word, in case of multiple occurences
				
				hiddenWord.remove(at: index) // remove "?" from hidden word
				hiddenWord.insert(title, at: index) // insert correct letter at same position
				hiddenWord.remove(at: lastIndex) // if there's multiple occurences
				hiddenWord.insert(title, at: lastIndex)  // if there's multiple occurences
				answerLabel.text = hiddenWord
				sender.isHidden = true // hide tapped button
			}
			
			// if done guessing word, show alert and load new word
			if !hiddenWord.contains("?") {
				let alert = UIAlertController(title: "Congratulations", message: "You saved the man", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { [weak self] action in
					self?.loadGame()
				}))
				present(alert, animated: true)
			}
		}
		
		if !wordToGuess.contains(buttonTitle) {
			guessAttempts -= 1
			checkScore()
			sender.isHidden = true
			

			if guessAttempts <= 1 {
				let alert = UIAlertController(title: "Game Over", message: "The word is \(wordToGuess)", preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { [weak self] action in
					self?.loadGame()
				}))
				present(alert, animated: true)
			}
		}
	}
	
	func checkScore() {
		switch guessAttempts {
			case 6: // draw the head
				let circlePath = UIBezierPath(arcCenter: CGPoint(x: 263, y: 222), radius: CGFloat(24), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
				
				let shapeLayer = CAShapeLayer()
				shapeLayer.path = circlePath.cgPath
				shapeLayer.fillColor = UIColor.clear.cgColor
				shapeLayer.strokeColor = UIColor.white.cgColor
				shapeLayer.lineWidth = 4.0
				view.layer.addSublayer(shapeLayer)
			case 5: // draw body line
				drawLine(fromX: 261, toX: 261, fromY: 244, toY: 314)
			case 4: // draw left arm
				drawLine(fromX: 261, toX: 231, fromY: 265, toY: 290)
			case 3: // draw right arm
				drawLine(fromX: 261, toX: 295, fromY: 265, toY: 290)
			case 2: // draw left leg
				drawLine(fromX: 261, toX: 231, fromY: 314, toY: 345)
			case 1: // draw right leg
				drawLine(fromX: 261, toX: 295, fromY: 314, toY: 345)
			default:
				print("My condolences, hangman...")
		}
	}
	
	func loadGame() {
		guessAttempts = 7
		nameTheButtons()
		answerLabel.text = generateRandomWord()
		
		let allSubLayers = view.layer.sublayers
		let currentSubLayerCount = allSubLayers!.count
		
		if currentSubLayerCount > 7 {
			let layersToRemove = allSubLayers!.count
			switch layersToRemove {
				case 8:
					view.layer.sublayers = allSubLayers?.dropLast(1)
				case 9:
					view.layer.sublayers = allSubLayers?.dropLast(2)
				case 10:
					view.layer.sublayers = allSubLayers?.dropLast(3)
				case 11:
					view.layer.sublayers = allSubLayers?.dropLast(4)
				case 12:
					view.layer.sublayers = allSubLayers?.dropLast(5)
				case 13:
					view.layer.sublayers = allSubLayers?.dropLast(6)
				default:
					print("No more layers to remove")
			}
		}
	}
}

