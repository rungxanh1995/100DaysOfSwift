//
//  UIViewController+Ext.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
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
	
	func showEmptyStateView(with message: String, in view: UIView) {
		let emptyStateView		= NAEmptyStateView(message: message)
		emptyStateView.frame	= view.bounds
		emptyStateView.alpha	= 0.0
		view.addSubview(emptyStateView)
		UIView.animate(withDuration: 0.5) { emptyStateView.alpha = 1.0 }
	}
	
	func dismissEmptyStateView(in view: UIView) {
		view.removeFromSuperview()
	}
}
