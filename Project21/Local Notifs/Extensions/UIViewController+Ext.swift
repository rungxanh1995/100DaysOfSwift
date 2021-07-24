//
//  UIViewController+Ext.swift
//  Local Notifs
//
//  Created by Joe Pham on 2021-07-24.
//

import UIKit


extension UIViewController {
	
	// challenge 1
	func presentAlert(title: String, message: String?) {
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
		ac.addAction(UIAlertAction(title: "Ok", style: .default))
		present(ac, animated: true)
	}
}
