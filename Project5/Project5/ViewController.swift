//
//  ViewController.swift
//  Project5: Anagram Word Game
//
//  Created by Joe Pham on 2021-01-12.
//

import UIKit

class ViewController: UITableViewController {
    // 1st array to hold all game words from input file "start.txt"
    var allWords = [String]()
    // 2nd array to hold all words the player has used in this game
    var usedWords = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Add an "add" button where once tapped the player can input their anagram answer
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        // Add a button to start the game again
        let leftBarButton = UIImage(systemName: "repeat.circle")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftBarButton, style: .plain, target: self, action: #selector(startGame))
        
        // Find URL path to "start.txt" file in the filesystem
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // Create a string from all text contents of the input file
            // Use "try?" to show if the code throws an error, return nil instead
            if let startWords = try? String(contentsOf: startWordsURL) {
                // Break down this string into words at each "\n"
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        // But even if "try?" returns nil, we have a backup here for allWords
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        // Start the game
        startGame()
        
        // End of viewDidLoad()
    }

    
    // Main game method
    @objc func startGame() {
        // Show title as 1 random word in the 1st array
        // Also the word the player has to find
        title = allWords.randomElement()
        
        usedWords.removeAll(keepingCapacity: true)
        
        // Call table view's reloadData() to force call numberOfRowsInSection again
        // Also it calls cellForRowAt repeatedly -> all to check if data loaded correctly
        tableView.reloadData()
        
        // End of startGame
    }
    
    
    // Foundation methods to handle table view data
    // 1. numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    // 2. cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    // End of altering tableView methods
    
    
    // Method to allow user input of the word they guess
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Your answer", message: "Enter a word with letters from \(title!)", preferredStyle: .alert)
        // Add a textbox for user to input the answer
        // Also means adding a UITextField instance
        ac.addTextField()
        
        // Define submitAction as a UIAlertAction with a trailing closure syntax for its param "handler"
        // code for "handler" is between { }
        // also using weak capture list for the current view controller as "self" and the "ac" above
        // as the code will use "self" and "ac" & Swift would default to strong reference cycle
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            // This closure can only call submit() if it captures the view controller
            // and "self" was also declared as weak referencing, hence "self?"
            self?.submit(answer)
        }
        // Add submitAction to this UIAlertController "ac"
        ac.addAction(submitAction)
        // Add Dismiss button to "ac"
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(ac, animated: true)
    }
    // End of promptForAnswer method
    
    
    // Methods to check the answer
    // 1. Check if the word can be made from given letters
    func isPossible(word: String) -> Bool {
        // a) Create a temporary word from lowercased title aka the word being randomly selected
        guard var tempWord = title?.lowercased() else { return false }
        // b) Loop through every letter in the player's answer
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
        // c) Lastly, return true only when all the characters passed the check from the for loop
        return true
    }
    
    // 2. Check if the word is used already
    func isOriginal(word: String) -> Bool {
        // ... by disallowing if the word is the same with the start word
        if word == title {
            return false
        } else {
        // ... by checking if the usedWords array contains the answer being submitted
        return !usedWords.contains(word)
        }
    }
    
    // 3. Check if the word is valid English
    func isReal(word: String) -> Bool {
//        // Disallow if answer is shorter than 3 letters
//        if word.count < 3 {
//            return false
//        } else {
            // a) by adopting native UITextChecker, which is an iOS class to spot spelling errors
            // but ALERT!: UITextChecker predates Swift. It's written in Obj-C, hence slightly different syntax
            let checker = UITextChecker()
            // b) then creating a range to hold character count of the word
            let range = NSRange(location: 0, length: word.utf16.count)
            // c) next, using rangeOfMisselledWord(in:) method of UITextChecker to scan the word for the whole range
            // rangeOfMisselledWord(in:) is in fact yet another NSRange structure to tell where the misspelling was found
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            // d) lastly, returns true/false dependent on whether misspelledRange.location equates NSNotFound
            return misspelledRange.location == NSNotFound
//        }
        
    }
    // End of methods to check for valid answer
    
    
    // Method to submit player answer from the alert
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        // If the lowercase answer passes these 3 conditions
        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    // Then add this answer to the start of usedWords array
                    // so the newest word appears at the top of the table view
                    usedWords.insert(lowerAnswer, at: 0)
                    
                    // Insert a new row into the table view w/ animation, so players can track visually
                    let indexPath = IndexPath(row: 0, section: 0) // this defines a specific indexPath of array usedWords
                    tableView.insertRows(at: [indexPath], with: .automatic) // this creates the animation
                    
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
    // End of submit method
    
    
    // Method to show error dependent on 3 conditionals
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
        
        // End of error message method
    }
    
    // End of class
}

