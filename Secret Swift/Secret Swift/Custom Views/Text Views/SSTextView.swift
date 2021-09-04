//
//  SSTextView.swift
//  Secret Swift
//
//  Created by Joe Pham on 2021-09-02.
//

import UIKit

class SSTextView: UITextView {

	override init(frame: CGRect, textContainer: NSTextContainer?) {
		super.init(frame: frame, textContainer: textContainer)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configure() {
		translatesAutoresizingMaskIntoConstraints = false
		
		backgroundColor 		= .systemBackground
		textColor				= .label
		tintColor				= .label
		textAlignment			= .natural
		font					= UIFont.monospacedSystemFont(ofSize: 17, weight: .medium)
		text					= "Sample secret text"
		
		minimumZoomScale		= 12
		autocorrectionType		= .no
		returnKeyType			= .default
		clearsOnInsertion		= false
		autocapitalizationType	= .none
		keyboardDismissMode		= .onDrag
	}
}
