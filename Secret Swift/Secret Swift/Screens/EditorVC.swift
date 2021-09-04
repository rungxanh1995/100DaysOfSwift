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
			presentAlertOnMainThread(title: "Biometry Unavailable", message: "Your device is not configured for biometric authentication.", buttonTitle: "OK")
		}
	}
	
	
	final func unlockSecretMessage() {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.title						= "Secret Unlocked"
			self.secretTextView.isHidden	= false
			self.authenticateButton.isHidden = true
			self.secretTextView.text		= KeychainWrapper.standard.string(forKey: Keys.secretMessage)
		}
	}
	
	
	@objc
	final func saveSecretMessage() {
		guard secretTextView.isHidden == false else { return }
		
		KeychainWrapper.standard.set(secretTextView.text, forKey: Keys.secretMessage)
		
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.didTapKeyboardDoneButton()
			self.title					= Bundle.main.displayName
			self.secretTextView.isHidden = true
			self.authenticateButton.isHidden = false
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

