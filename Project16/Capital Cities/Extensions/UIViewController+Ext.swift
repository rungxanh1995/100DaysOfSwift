//
//  UIViewController+Ext.swift
//  Capital Cities
//
//  Created by Joe Pham on 2021-07-07.
//

import UIKit
import SafariServices

// challenge 3
extension UIViewController {
	func presentSafariVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.modalPresentationStyle		= .automatic
		safariVC.preferredControlTintColor	= .systemPink
		present(safariVC, animated: true)
	}
}
