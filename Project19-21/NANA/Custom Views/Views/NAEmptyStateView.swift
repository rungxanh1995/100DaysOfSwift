//
//  NAEmptyStateView.swift
//  NANA
//
//  Created by Joe Pham on 2021-07-25.
//

import UIKit

class NAEmptyStateView: UIView {
	
	let messageLabel 	= NATitleLabel(textAlignment: .center)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	convenience init(message: String) {
		self.init(frame: .zero)
		messageLabel.text = message
	}
	
	private func configure() {
		backgroundColor = .systemBackground
		configureMessageLabel()
	}
	
	private func configureMessageLabel() {
		addSubview(messageLabel)
		messageLabel.numberOfLines	= 3
		messageLabel.textColor		= .secondaryLabel
		messageLabel.positionInCenter(of: self)
		
		messageLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
	}
}
