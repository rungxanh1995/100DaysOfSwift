//
//  ViewController.swift
//  Project8
//
//  Created by Joe Pham on 2021-01-20.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
	var answersLabel: UILabel!
	var currentAnswer: UITextField!
	var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    var activatedButtons = [UIButton]()
    var possibleAnswers = [String]()
	private var level = 1   // current game lavel
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
	
	override func loadView() {
		setUpGameLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }
}

extension ViewController {
	// main game logic
    private func loadLevel() {
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            var clueString = ""
            var cleanedAnswerString = ""
            var letterBits = [String]()
            
            if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
                if let levelContents = try? String(contentsOf: levelFileURL) {
                    var lines = levelContents.components(separatedBy: "\n")
					lines.shuffle()
                    
                    for (index, line) in lines.enumerated() {
                        let parts = line.components(separatedBy: ": ")
                        let rawAnswer = parts[0]
                        let clue = parts[1]
						clueString += "\(index + 1).\t\(clue)\n"
						
                        let cleanedAnswerWord = rawAnswer.replacingOccurrences(of: "|", with: "")
                        cleanedAnswerString += "\(cleanedAnswerWord.count) letters\n"
                        possibleAnswers.append(cleanedAnswerWord)
						
                        let bits = rawAnswer.components(separatedBy: "|")
                        letterBits += bits
                    }
                }
            }
        
            DispatchQueue.main.async {
                cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
                answersLabel.text = cleanedAnswerString.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            letterBits.shuffle()
            if letterButtons.count == letterBits.count {
                for i in 0..<letterButtons.count {
                    DispatchQueue.main.async {
                        letterButtons[i].setTitle(letterBits[i], for: .normal)
                    }
                }
            }
        }
    }
    
	func levelUp(action: UIAlertAction) {
        level += 1
        score = 0
        possibleAnswers.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.alpha = 1
			btn.isUserInteractionEnabled = true
        }
    }
}

