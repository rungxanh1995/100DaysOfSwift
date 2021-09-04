//
//  UIViewController+Ext.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-04.
//

import UIKit.UIViewController

extension UIViewController {
	
	func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default))
			self.present(alertVC, animated: true)
		}
	}
	
	
	// challenge 2
	func presentPasswordPrompt(isFirstTime: Bool, title: String, message: String? = nil, completed: @escaping (String?) -> Void) {
		
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		if isFirstTime {
			// type 1st password
			ac.addTextField() { textField in
				textField.isSecureTextEntry = true
				textField.placeholder		= "Password"
			}
			
			// reconfirm password
			ac.addTextField() { textField in
				textField.isSecureTextEntry = true
				textField.placeholder		= "Confirm password"
			}
			
			let setAction = UIAlertAction(title: "Set Password", style: .default, handler: { [weak self, weak ac] action in
				guard let password			= ac?.textFields?[0].text,
					  let confirmPaswword	= ac?.textFields?[1].text,
					  password == confirmPaswword
				else {
					self?.presentAlertOnMainThread(title: "Password Didn't Match", message: "Try entering the same password in both textboxes", buttonTitle: "OK")
					return
				}
				completed(password)
			})
			
			ac.addAction(setAction)
			
		} else {
			ac.addTextField() { textField in
				textField.isSecureTextEntry = true
				textField.placeholder		= "Password"
			}
			
			let unlockAction = UIAlertAction(title: "Unlock", style: .default, handler: { [weak ac] action in
				guard let password = ac?.textFields?[0].text else { return }
				completed(password)
			})
			
			ac.addAction(unlockAction)
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			completed(nil)
		}
		
		ac.addAction(cancelAction)
		present(ac, animated: true)
	}
}
