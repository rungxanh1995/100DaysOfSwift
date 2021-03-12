//
//  ViewController.swift
//  Project5: Anagram Word Game
//
//  Created by Joe Pham on 2021-03-02.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()	// hold all game words
	
	// Project 12, challenge 3
	var gameState = GameState(currentWord: "", usedWords: [String]())
	var gameStateKey = "SavedGameState"
	
	let defaults = UserDefaults.standard
	let mainQueue = DispatchQueue.main
	let globalQueue = DispatchQueue.global()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // "Add" button to input new word
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        // Button to start the game again
        let leftBarButton = UIImage(systemName: "repeat.circle")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarButton, style: .plain, target: self, action: #selector(startNewGame))
        
        // Find URL path to "start.txt" file in the filesystem
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")	// Break down string into words at "\n"
            }
        }
        
        // A backup for allWords
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
		
		globalQueue.async { [weak self] in
			self?.loadGameState()
		}
    }

	
	// Project 12, challenge 3
	func saveGameState() {
		let jsonEncoder = JSONEncoder()
		
		if let encodedState = try? jsonEncoder.encode(gameState) {
			defaults.set(encodedState, forKey: gameStateKey)
		} else {
			print("Failed to save game state.")
		}
	}
	
	// Project 12, challenge 3
	func loadGameState() {
		if let loadedState = defaults.object(forKey: gameStateKey) as? Data {
			let jsonDecoder = JSONDecoder()
			
			if let decodedState = try? jsonDecoder.decode(GameState.self, from: loadedState) {
				gameState = decodedState
			}
		}
		
		// If no word found in gameState: start new game
		if gameState.currentWord.isEmpty {
			mainQueue.async {
				self.startNewGame()
			}
		} else {
			mainQueue.async {
				self.loadGameStateView()
			}
		}
	}
	
	func loadGameStateView() {
		title = gameState.currentWord
		tableView.reloadData()
	}
	
	
	// Project 12, challenge 3
	// MAIN GAME METHOD
	@objc func startNewGame() {
		//        title = 	// random word the player has to play
		gameState.currentWord = allWords.randomElement() ?? "silkworm"
		gameState.usedWords.removeAll(keepingCapacity: true)
		
		globalQueue.async { [weak self] in
			self?.saveGameState()
			
			self?.mainQueue.async {
				self?.loadGameStateView()
			}
		}
	}
    
    
    // FOUNDATION METHODS TO HANDLE TABLE VIEW DATA
    // 1. numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return gameState.usedWords.count
    }
    // 2. cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
		cell.textLabel?.text = gameState.usedWords[indexPath.row]
        return cell
    }
    
    
    // METHOD TO ALLOW USER INPUT OF THE WORD THEY GUESS
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Your answer", message: "Enter a word with letters from \(title!)", preferredStyle: .alert)

        ac.addTextField()
        

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
		let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)

        ac.addAction(submitAction)
        ac.addAction(dismissAction)
        self.present(ac, animated: true)
    }
    
    
    // METHODS TO CHECK THE ANSWER
    // 1. Check if the word can be made from given letters
    func isPossible(word: String) -> Bool {

        guard var tempWord = title?.lowercased() else { return false }

        for letter in word {
            // ... if that letter exists at a specific position
            // ... then shrink the temporary word by that letter at that very position & continue the loop
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                // ... else no need to check, return false for the entire answer
                return false
            }
        }

        return true
    }
    
    // 2. Check if the word is used already
    func isOriginal(word: String) -> Bool {
        // ... by disallowing if the word is the same with the start word
        if word == title {
            return false
        } else {
        // ... by checking if the usedWords array contains the answer being submitted
			return !gameState.usedWords.contains(word)
        }
    }
    
    // 3. Check if the word is valid English
    func isReal(word: String) -> Bool {

            let checker = UITextChecker()
            // b) then creating a range to hold character count of the word
            let range = NSRange(location: 0, length: word.utf16.count)
            // c) next, using rangeOfMisselledWord(in:) method of UITextChecker to scan the word for the whole range
            // rangeOfMisselledWord(in:) is in fact yet another NSRange structure to tell where the misspelling was found
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            // d) lastly, returns true/false dependent on whether misspelledRange.location equates NSNotFound
            return misspelledRange.location == NSNotFound
    }
    
    
    // METHOD TO SUBMIT PLAYER ANSWER FROM THE ALERT
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        // If the lowercase answer passes these 3 conditions
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    // Then add this answer to the start of usedWords array
                    // so the newest word appears at the top of the table view
					gameState.usedWords.insert(lowerAnswer, at: 0)
					
					// Project 12, challenge 3
					globalQueue.async { [weak self] in
						self?.saveGameState()	// save the table view rows
					}
                    
                    // Insert a new row into the table view
                    let indexPath = IndexPath(row: 0, section: 0) //specific indexPath of array usedWords
                    tableView.insertRows(at: [indexPath], with: .automatic) // creates the animation
                    
                    // Force Swift to exit the method once the table is updated
                    return
                }
                // but if not real
                else { showErrorMessage(answer: lowerAnswer) }
            }
            // if not original
            else { showErrorMessage(answer: lowerAnswer) }
        }
        // if not possible
        else { showErrorMessage(answer: lowerAnswer) }
    }
    
    
    // METHOD TO SHOW ERROR DEPENDENT ON 3 CONDITIONALS
    func showErrorMessage(answer: String) {
        var errorTitle: String?
        var errorMessage: String?
        
        // If the answer is not proper English and short
        if answer.count < 3 {
            errorTitle = "Short guess"
            errorMessage = "Don't be lazy! Try a longer word"
        }
        // Pass in the answer (already lowercased from the calls right above) to "word" param
        else if !isPossible(word: answer) {
            guard let title = title?.lowercased() else { return }
            errorTitle = "Impossibru!"
            errorMessage = "You know for damn sure \(answer) isn't created from \(title)!"
        }
        else if !isOriginal(word: answer) {
            errorTitle = "Word used already"
            errorMessage = "Isn't it funny to repeat yourself? Be original!"
        }
        else if !isReal(word: answer) {
            errorTitle = "You word inventor you"
            errorMessage = "Don't make stuff up you know!"
        }
        // Present the alert
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Try another", style: .default, handler: nil))
        present(ac, animated: true, completion: nil)
    }
}
