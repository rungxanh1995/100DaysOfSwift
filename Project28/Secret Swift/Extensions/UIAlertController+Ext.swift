//
//  UIAlertController+Ext.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-04.
//

import UIKit

extension UIAlertController {
	
	func addActions(_ actions: UIAlertAction...) {
		actions.forEach { addAction($0) }
	}
	
	
	func addTextFields(_ numOfFields: Int) {
		for _ in 0..<numOfFields { addTextField() }
	}
}

