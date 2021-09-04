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
}
