//
//  UIAlertController+Ext.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-08.
//

import UIKit

extension UIAlertController {
	
	func addActions(_ actions: UIAlertAction...) {
		actions.forEach { addAction($0) }
	}
}
