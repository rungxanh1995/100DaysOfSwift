//
//  UIView+Ext.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import UIKit

extension UIView {
	
	func addSubviews(_ view: UIView...) { view.forEach(addSubview) }
}
