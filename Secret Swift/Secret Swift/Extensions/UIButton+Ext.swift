//
//  UIButton+Ext.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-02.
//

import UIKit.UIButton

extension UIButton {

	func placeInCenter(of superview: UIView) {
		superview.addSubview(self)
		translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			centerXAnchor.constraint(equalTo: superview.centerXAnchor),
			centerYAnchor.constraint(equalTo: superview.centerYAnchor),
			heightAnchor.constraint(equalToConstant: 44),
		])
	}
}
