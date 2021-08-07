//
//  SSTitleLabel.swift
//  SelfieShare
//
//  Created by Joe Pham on 2021-08-06.
//

import UIKit

class SSTitleLabel: UILabel {
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
		self.init(frame: .zero)
		self.textAlignment			= textAlignment
		self.font					= UIFont.systemFont(ofSize: fontSize, weight: .regular)
	}
	
	private func configure() {
		textColor					= .label
		adjustsFontSizeToFitWidth	= true
		lineBreakMode 				= .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
}
