//
//  UIView+Ext.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-02.
//

import UIKit.UIView


extension UIView {
	
	func addSubviews(_ view: UIView...) { view.forEach(addSubview) }
	
	func pinToEdges(of superview: UIView) {
		superview.addSubview(self)
		
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: superview.topAnchor),
			leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
			trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
			bottomAnchor.constraint(equalTo: superview.bottomAnchor)
		])
	}
}
