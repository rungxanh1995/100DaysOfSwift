//
//  UIAlertController+Ext.swift
//  MemeGenerator
//
//  Created by Joe Pham on 2021-08-29.
//

import UIKit

extension UIAlertController {
	
	func addActions(_ actions: UIAlertAction...) {
		actions.forEach { addAction($0) }
	}
}
