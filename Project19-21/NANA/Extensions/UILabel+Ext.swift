//
//  UILabel+Ext.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-28.
//

import UIKit

extension UILabel {
	
	func positionInCenter(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			centerYAnchor.constraint(equalTo: superview.centerYAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 40),
			trailingAnchor.constraint (equalTo: superview.trailingAnchor, constant: -40),
		])
	}
}
