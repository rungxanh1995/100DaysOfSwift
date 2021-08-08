//
//  UIViewController+Ext.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import UIKit

extension UIViewController {
	
	func presentAlertOnMainThread(title: String, message: String, buttonTitle: String, otherActions: [UIAlertAction]? = nil) {
		DispatchQueue.main.async {
			let alertVC			= UIAlertController(title: title, message: message, preferredStyle: .alert)
			let defaultAction	= UIAlertAction(title: buttonTitle, style: .default)
			alertVC.addAction(defaultAction)
			
			if otherActions != nil { otherActions?.forEach { alertVC.addActions($0) } }
			self.present(alertVC, animated: true)
		}
	}
	
	// challenge 3
	func updateNavBarLeftItem(with item: UIBarButtonItem?) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self, let item = item else {
				self?.navigationItem.leftBarButtonItem = nil
				return
			}
			self.navigationItem.leftBarButtonItem = item
		}
	}
}
