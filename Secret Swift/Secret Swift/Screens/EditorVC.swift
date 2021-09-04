//
//  EditorVC.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-02.
//

import UIKit
import LocalAuthentication

class EditorVC: UIViewController {
	
	// MARK: Properties
	private var secretTextView		: SSTextView!
	private var authenticateButton	: SSButton!
	private var isPasswordSet		: Bool! // challenge 2

	
	// MARK: Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
	}
}


// MARK: Logic

extension EditorVC {
	
	@objc
	func didTapAuthenticate() {
		let context = LAContext()
		var error	: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			
			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: AlertContext.authenticateViaFaceID) { [weak self] success, authenticationError in
				guard let self = self else { return }
				if success {
					self.unlockSecretMessage()
				} else {
					self.presentAlertOnMainThread(title: "Face Not Recognized", message: "Try Again", buttonTitle: "OK")
				}
			}
		} else {
			unlockWithPassword() // challenge 2
		}
	}
	
	
	@objc
	final func unlockSecretMessage() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self, self.secretTextView.isHidden else { return }
			self.title							= "Secret Unlocked"
			self.authenticateButton.isHidden	= true
			self.secretTextView.isHidden		= false
			self.secretTextView.text			= KeychainWrapper.standard.string(forKey: Keys.secretMessage)
			self.configureLockButton(isSecretHidden: false)  // challenge 1
			self.configurePasswordButton(isSecretHidden: false) // challenge 2
		}
	}
	
	
	@objc
	final func saveSecretMessage() {
		guard secretTextView.isHidden == false else { return }
		
		KeychainWrapper.standard.set(secretTextView.text, forKey: Keys.secretMessage)
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.didTapKeyboardDoneButton()
			self.title							= Bundle.main.displayName
			self.authenticateButton.isHidden	= false
			self.secretTextView.isHidden		= true
			self.configureLockButton(isSecretHidden: true) // challenge 1
			self.configurePasswordButton(isSecretHidden: true) // challenge 2
		}
	}
}


// MARK: Challenges

extension EditorVC {
	
	// challenge 1
	final func configureLockButton(isSecretHidden: Bool) {
		if isSecretHidden {
			navigationItem.rightBarButtonItem = nil
		} else {
			let lockButton = UIBarButtonItem(image: SFSymbol.unlock, style: .plain, target: self, action: #selector(saveSecretMessage))
			navigationItem.rightBarButtonItem = lockButton
		}
	}
	
	
	// challenge 2
	final func configurePasswordButton(isSecretHidden: Bool) {
		
		let unlock = UIAction(title: "Unlock with Password", image: SFSymbol.unlock, handler: { [weak self] _ in self?.unlockWithPassword()
		})
		
		let newPassword	= UIAction(title: "Set New Password", image: SFSymbol.reset, handler: { [weak self] _ in self?.setNewPassword()
		})
		
		let	actions	= isSecretHidden ? [unlock, newPassword] : [newPassword]
		let menu = UIMenu(title: "Password Manager", image: nil, identifier: nil, options: [], children: actions)
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Password", image: nil, primaryAction: nil, menu: menu)
	}
	
	
	// challenge 2
	final func unlockWithPassword() {
		isPasswordSet = KeychainWrapper.standard.hasValue(forKey: Keys.isPasswordSet)
		
		if isPasswordSet {
			presentPasswordPrompt(isFirstTime: false, title: "Enter Password", message: "Type your saved password to unlock secret messages") { [weak self] password in
				guard let self = self, let password = password else { return }
				let savedPassword = KeychainWrapper.standard.string(forKey: Keys.password)
				
				if password == savedPassword {
					self.unlockSecretMessage()
				}
				else {
					self.presentAlertOnMainThread(title: "Password Didn't Match", message: "Please try again", buttonTitle: "OK")
				}
			}
		}
	}
	
	
	// challenge 2 helper
	final func setNewPassword() {
		presentPasswordPrompt(isFirstTime: true, title: "Set Password", message: "To lock and unlock secret messages") { [weak self] password in
			guard let self = self, let password = password else { return }
			KeychainWrapper.standard.set(password, forKey: Keys.password)
			
			self.isPasswordSet = true
			KeychainWrapper.standard.set(self.isPasswordSet, forKey: Keys.isPasswordSet)
		}
	}
}


// MARK: UI Config

extension EditorVC {
	
	final func configureVC() {
		view.backgroundColor = .systemBackground
		title = Bundle.main.displayName
		
		configureSecretTextView(in: view)
		configureNotificationObservers(in: self)
		configureAuthenticateButton(in: view)
		configureLockButton(isSecretHidden: secretTextView.isHidden) // challenge 1
		configurePasswordButton(isSecretHidden: secretTextView.isHidden) // challenge 2
	}
	
	
	final func configureSecretTextView(in view: UIView) {
		secretTextView			= SSTextView(frame: .zero)
		secretTextView.pinToEdges(of: view)
		secretTextView.isHidden = true
		
		setupKeyboard(for: secretTextView)
	}
	
	
	final func setupKeyboard(for textView: UITextView) {
		let toolbar		= UIToolbar()
		let flexSpace	= UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let doneButton	= UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapKeyboardDoneButton))

		toolbar.setItems([flexSpace, doneButton], animated: true)
		toolbar.sizeToFit()
		textView.inputAccessoryView = toolbar
	}


	@objc
	final func didTapKeyboardDoneButton() {
		secretTextView.resignFirstResponder()
	}
	
	
	private func configureAuthenticateButton(in view: UIView) {
		authenticateButton = SSButton(backgroundColor: .systemBlue, title: "Authenticate")
		authenticateButton.addTarget(self, action: #selector(didTapAuthenticate), for: .touchUpInside)
		authenticateButton.placeInCenter(of: view)
	}
	
	
	private func configureNotificationObservers(in vc: Any) {
		let notification = NotificationCenter.default
		notification.addObserver(vc, selector: #selector(adjustTextViewForKeyboard), name: UIResponder.keyboardDidHideNotification, object: nil)
		notification.addObserver(vc, selector: #selector(adjustTextViewForKeyboard), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
		notification.addObserver(vc, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)
	}
	
	
	@objc
	func adjustTextViewForKeyboard(notification: Notification) {
		guard let keyboardValue 	= notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		let keyboardScreenEndFrame 	= keyboardValue.cgRectValue
		let keyboardViewEndFrame 	= view.convert(keyboardScreenEndFrame, from: view.window)
		
		if notification.name == UIResponder.keyboardWillHideNotification {
			secretTextView.contentInset = .zero
		} else {
			secretTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - secretTextView.safeAreaInsets.bottom, right: 0)
		}
		secretTextView.scrollIndicatorInsets = secretTextView.contentInset
		
		let selectedRage = secretTextView.selectedRange
		secretTextView.scrollRangeToVisible(selectedRage)
	}
}

