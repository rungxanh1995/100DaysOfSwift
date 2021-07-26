//
//  NATitleLabel.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import UIKit

class NATitleLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment 					= textAlignment
	}
	
	
	private func configure() {
		textColor							= .label
		font								= UIFont.preferredFont(forTextStyle: .headline)
		adjustsFontSizeToFitWidth			= true
		adjustsFontForContentSizeCategory 	= true // dynamic type support
		minimumScaleFactor					= 0.9
		lineBreakMode						= .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}
	
}
