//
//  ViewController.swift
//  Project7-9
//
//  Created by Joe Pham on 2021-02-01.
//

import UIKit

class ViewController: UIViewController {

    // UI vars
    var attemptsLabel: UILabel!
    var clueLabel: UILabel!
    var answerLabel: UILabel!
    var currentAnswer: UITextField!
    var alphabetButtons = [UIButton]()
    var alphabetCharList = [Character]()
    
    var attempt = 7
    
    override func loadView() {
        // Top root view
        view = UIView()
        view.backgroundColor = .white;
        
        // Define the attemptsLabel
        attemptsLabel = UILabel()
        attemptsLabel.translatesAutoresizingMaskIntoConstraints = false
        attemptsLabel.textAlignment = .right
        attemptsLabel.text = "Attempts left: 7"
        view.addSubview(attemptsLabel)
        
        // Define the image view
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(imageView)
        
        // Define the cluesLabel
        clueLabel = UILabel()
        clueLabel.translatesAutoresizingMaskIntoConstraints = false
        clueLabel.font = UIFont.systemFont(ofSize: 24)
        clueLabel.text = "CLUES"
        clueLabel.numberOfLines = 0    // as many as it needs
        view.addSubview(clueLabel)
        
        // Define the answersLabel
        answerLabel = UILabel()
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.font = UIFont.systemFont(ofSize: 24)
        answerLabel.text = "ANSWERS"
        answerLabel.numberOfLines = 0  // as many as it needs
        answerLabel.textAlignment = .right
        view.addSubview(answerLabel)
        
        clueLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answerLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        // Define the currentAnswer
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.isUserInteractionEnabled = false  // disable keyboard
        view.addSubview(currentAnswer)
        
        // Define the alphabet buttons
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.cornerRadius = 16
        buttonsView.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            attemptsLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            attemptsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: attemptsLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 350),
            imageView.heightAnchor.constraint(equalToConstant: 412),
            clueLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            clueLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            clueLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            answerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            answerLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answerLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            answerLabel.heightAnchor.constraint(equalTo: clueLabel.heightAnchor),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: clueLabel.bottomAnchor, constant: 20),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor, constant: 50),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
        ])
        
        // Define the alphabet buttons
        let buttonWidth = 83
        let buttonHeight = 80
        
        // Define max index of button rows & columns to loop through
        let maxButtonRowIndex = 3
        let maxButtonColumnIndex = 8
        
        // Create the grid of 4x5 word buttons
        for row in 0...maxButtonRowIndex {
            for column in 0...maxButtonColumnIndex {
                // Create a button and set font size
                let alphabetButton = UIButton(type: .system)
                alphabetButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                
                alphabetButton.setTitle("A", for: .normal)
                
                alphabetButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                // Calculate the button frame using its column & row
                let buttonFrame = CGRect(x: column * buttonWidth, y: row * buttonHeight, width: buttonWidth, height: buttonHeight)
                alphabetButton.frame = buttonFrame
                
                buttonsView.addSubview(alphabetButton)
                
                // Also add the button to array letterButtons
                alphabetButtons.append(alphabetButton)
            }
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @objc func letterTapped() {
        
    }

}

