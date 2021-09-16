//
//  UIViewController+Ext.swift
//  Exploding Monkeys
//
//  Created by Joe Pham on 2021-09-06.
//

import UIKit

extension UIViewController {
	
	func shouldHideUIElements(_ isHidden: Bool, elements: UIView...) {
		if isHidden { elements.forEach { $0.isHidden = true } }
		else		{ elements.forEach { $0.isHidden = false } }
	}
}
