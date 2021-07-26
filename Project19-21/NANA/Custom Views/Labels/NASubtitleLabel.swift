//
//  NASubtitleLabel.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import UIKit

class NASubtitleLabel: UILabel {

    
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(textAlignment: NSTextAlignment) {
		self.init(frame: .zero)
		self.textAlignment = textAlignment
	}
	
	private func configure() {
		textColor 							= .secondaryLabel
		font								= UIFont.preferredFont(forTextStyle: .subheadline)
		adjustsFontForContentSizeCategory 	= true // dynamic type support
		lineBreakMode 						= .byTruncatingTail
		translatesAutoresizingMaskIntoConstraints = false
	}

}
