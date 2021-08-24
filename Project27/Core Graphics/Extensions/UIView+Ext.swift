//
//  UIView+Ext.swift
//  Core Graphics
//
//  Created by Joe Pham on 2021-08-20.
//

import UIKit.UIView


extension UIView {
	
	func addSubviews(_ view: UIView...) { view.forEach(addSubview) }
	
	func pinToEdges(of superview: UIView) {
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
}
