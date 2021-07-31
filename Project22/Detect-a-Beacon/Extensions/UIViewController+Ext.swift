//
//  UIViewController+Ext.swift
//  Detect-a-Beacon
//
//  Created by Joe Pham on 2021-07-30.
//

import UIKit

extension UIViewController {
	
	func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
		DispatchQueue.main.async {
			let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default))
			self.present(alertVC, animated: true)
		}
	}
}
